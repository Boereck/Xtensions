package de.fhg.fokus.xtensions.iteration

import java.util.PrimitiveIterator
import java.util.stream.IntStream
import java.util.Spliterators
import java.util.stream.StreamSupport
import java.util.Spliterator
import java.util.stream.LongStream
import java.util.stream.DoubleStream

/**
 * This class contains static methods for the primitive iterators defined in {@link PrimitiveIterator}.
 * The methods are intended to be used as extension methods.
 * The class is not intended to be instantiated.
 */
final class PrimitiveIteratorExtensions {
	
	private new() {
		throw new IllegalStateException("PrimitiveIteratorExtensions not intended to be instantiated")
	}
	
	//////////////////////////////////
	// for PrimitiveIterator.OfInt  //
	//////////////////////////////////
	
	/**
	 * Convenience method to turn a primitive iterator into a stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def IntStream streamRemaining(PrimitiveIterator.OfInt wrapped) { 
		val spliterator = wrapped.toSpliterator
		StreamSupport.intStream(spliterator, false)
	}
	
	/**
	 * Convenience method to turn a primitive iterator into a parallel stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def IntStream parallelStreamRemaining(PrimitiveIterator.OfInt wrapped) {  
		val spliterator = wrapped.toSpliterator
		StreamSupport.intStream(spliterator, true)
	}
	
	private static def Spliterator.OfInt toSpliterator(PrimitiveIterator.OfInt wrapped) {
		val characteristics = Spliterator.NONNULL
		Spliterators.spliteratorUnknownSize(wrapped,characteristics)
	}
	
	
	///////////////////////////////////
	// for PrimitiveIterator.OfLong  //
	///////////////////////////////////
	
	/**
	 * Convenience method to turn a primitive iterator into a stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def LongStream streamRemaining(PrimitiveIterator.OfLong wrapped) { 
		val spliterator = wrapped.toSpliterator
		StreamSupport.longStream(spliterator, false)
	}
	
	/**
	 * Convenience method to turn a primitive iterator into a parallel stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def LongStream parallelStreamRemaining(PrimitiveIterator.OfLong wrapped) {  
		val spliterator = wrapped.toSpliterator
		StreamSupport.longStream(spliterator, true)
	}
	
	private static def Spliterator.OfLong toSpliterator(PrimitiveIterator.OfLong wrapped) {
		val characteristics = Spliterator.NONNULL
		Spliterators.spliteratorUnknownSize(wrapped,characteristics)
	}
	
	
	/////////////////////////////////////
	// for PrimitiveIterator.OfDouble  //
	/////////////////////////////////////
	
	/**
	 * Convenience method to turn a primitive iterator into a stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def DoubleStream streamRemaining(PrimitiveIterator.OfDouble wrapped) { 
		val spliterator = wrapped.toSpliterator
		StreamSupport.doubleStream(spliterator, false)
	}
	
	/**
	 * Convenience method to turn a primitive iterator into a parallel stream. 
	 * Best effort transformation from iterator to stream. Does not make any assumptions,
	 * other than that the elements returned by the iterator are not null.
	 */
	static def DoubleStream parallelStreamRemaining(PrimitiveIterator.OfDouble wrapped) {  
		val spliterator = wrapped.toSpliterator
		StreamSupport.doubleStream(spliterator, true)
	}
	
	private static def Spliterator.OfDouble toSpliterator(PrimitiveIterator.OfDouble wrapped) {
		val characteristics = Spliterator.NONNULL
		Spliterators.spliteratorUnknownSize(wrapped,characteristics)
	}
}
