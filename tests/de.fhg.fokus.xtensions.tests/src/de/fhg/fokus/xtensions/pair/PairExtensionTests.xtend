package de.fhg.fokus.xtensions.pair

import org.junit.Test
import static org.junit.Assert.*
import static extension de.fhg.fokus.xtensions.pair.PairExtensions.*
import java.util.concurrent.atomic.AtomicBoolean

class PairExtensionTests {
	
	/////////////
	// consume //
	/////////////
	
	@Test def void testConsume() {
		val expectedKey = "foo"
		val expectedVal = 3
		val tst = expectedKey -> expectedVal
		val called = new AtomicBoolean(false)
		tst.consume[k, v|
			assertEquals(expectedKey, k)
			assertEquals(expectedVal, v)
			called.set(true)
		]
		assertTrue(called.get)
	}
	
	@Test def void testConsumeKeyNull() {
		val String expectedKey = null
		val expectedVal = 3
		val tst = expectedKey -> expectedVal
		val called = new AtomicBoolean(false)
		tst.consume[k, v|
			assertEquals(expectedKey, k)
			assertEquals(expectedVal, v)
			called.set(true)
		]
		assertTrue(called.get)
	}
	
	@Test def void testConsumeValueNull() {
		val expectedKey = "foo"
		val Integer expectedVal = null
		val tst = expectedKey -> expectedVal
		val called = new AtomicBoolean(false)
		tst.consume[k, v|
			assertEquals(expectedKey, k)
			assertEquals(expectedVal, v)
			called.set(true)
		]
		assertTrue(called.get)
	}
	
//	//////////
//	// test //
//	//////////
//	
//	@Test def void testTestTrue() {
//		val result = ("foo" -> "bar").test[$0.length == $1.length]
//		assertTrue(result)
//	}
//	
//	@Test def void testTestFalse() {
//		val result = ("foo" -> "baar").test[$0.length == $1.length]
//		assertFalse(result)
//	}
	
	/////////////
	// combine //
	/////////////
	
	@Test def void testCombine() {
		val result = ("fizz" -> "buzz").combine[$0 + $1]
		assertEquals("fizzbuzz", result)
	}
	
	/////////////////
	// safeCombine //
	/////////////////
	
	@Test def void testSafeCombineFirstNull() {
		val result = (null -> "buzz").safeCombine[fail() $0 + $1]
		assertFalse(result.present)
	}
	
	@Test def void testSafeCombineSecondNull() {
		val result = ("bar" -> null).safeCombine[fail() $0 + $1]
		assertFalse(result.present)
	}
	
	@Test def void testSafeCombineReturnNull() {
		val result = ("fizz" -> "buzz").safeCombine[null]
		assertFalse(result.present)
	}
	
	@Test def void testSafeCombine() {
		val result = ("fizz" -> "buzz").safeCombine[$0 + $1]
		assertEquals("fizzbuzz", result.get)
	}
}