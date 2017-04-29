package de.fhg.fokus.xtenders.iterator;

import java.util.PrimitiveIterator;
import java.util.PrimitiveIterator.OfLong;
import java.util.function.LongConsumer;
import java.util.stream.LongStream;

/**
 * This interface is a specialized version of an {@code Iterable<Double>}
 * providing a {@link PrimitiveIterator.OfDouble} which allows iteration over
 * unboxed primitive values.
 */
public interface LongIterable extends Iterable<Long> {
	
	/**
	 * Returns a primitive iterator over elements of type {@code long}. This
	 * method specializes the super-interface method.
	 * 
	 * @return a PrimitiveIterator.OfLong
	 */
	public OfLong iterator();
	
	/**
	 * Iterates over all elements of the iterable and calls {@code consumer} for
	 * each element. The default implementation uses {@link #iterator()} to get
	 * the elements of the iterable. Implementations are encouraged to overwrite
	 * this method with a more efficient implementation.
	 * 
	 * @param consumer
	 *            the action to be called for each element in the iterable.
	 */
	default void forEachLong(LongConsumer consumer) {
		final OfLong iterator = iterator();
		while(iterator.hasNext()) {
			long next = iterator.nextLong();
			consumer.accept(next);
		}
	}
	
	/**
	 * Returns an {@link LongStream} based on the elements in the iterable. <br>
	 * The default implementation returns a stream uses
	 * {@link PrimitiveIteratorExtensions#stream(OfLong)} with the iterator from
	 * {@link #iterator()} to construct the resulting stream. It is highly
	 * recommended for the implementations of this interface to provide an own
	 * implementation of this method.
	 * 
	 * @return a LongStream to iterate over the elements of this iterable.
	 */
	default LongStream stream() {
		final OfLong iterator = iterator();
		return PrimitiveIteratorExtensions.stream(iterator);
	}
	
	// TODO public static LongIterable generate(final LongSupplier s)
	// TODO public static LongIterable iterate(final long seed, final LongUnaryOperator f)
}
