package de.fhg.fokus.xtensions.iteration

import org.junit.Test

import static extension de.fhg.fokus.xtensions.iteration.ArrayExtensions.*
import static org.junit.Assert.*
import java.time.LocalDateTime
import java.time.ZoneId

/**
 * Test cases for {@link ArrayExtensions}
 */
class ArrayExtensionsTest {
	
	@Test(expected=NullPointerException) def testForEachArrayNull() {
		val Object[] arr = null
		arr.forEach [
			fail()
		]
	}
	
	@Test(expected=NullPointerException) def testForEachActionNull() {
		val Object[] arr = #[]
		arr.forEach(null)
	}
	
	@Test def testForEachEmptyArray() {
		val Object[] arr = #[]
		arr.forEach [
			fail()
		]
	}
	
	@Test def testForEachOneElementArray() {
		val Object[] arr = #["foo"]
		val result = newArrayList
		arr.forEach [
			result.add(it)
		]
		assertArrayEquals(arr, result)
	}
	
	@Test def testForEachSomeElementsArray() {
		val Object[] arr = #["foo", 42, LocalDateTime.now(ZoneId.systemDefault)]
		val result = newArrayList
		arr.forEach [
			result.add(it)
		]
		assertArrayEquals(arr, result)
	}
}