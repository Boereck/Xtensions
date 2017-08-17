package de.fhg.fokus.xtensions.incubation.exceptions

import java.util.Optional
import java.util.NoSuchElementException

/**
 * Result of computation of non-null result value .
 * Constructing try:
 * <ul>
 * 	<li>tryWith</li>
 * 	<li>doTry</li>
 * 	<li>flatTry</li>
 * 	<li>completedSuccessfully</li>
 * 	<li>completedExceptionally</li>
 * </ul>
 * All methods starting with {@code if} react on the result and simply return 
 * the Try on which they were invoked again. If the handlers passed to these methods
 * throw an exception, they well be thrown from the {@code if*} method that was called.<br>
 * <br>
 * The methods starting with {@code then} execute the given handler when the 
 */
final class Try<R> {
	private val Exception e
	private val R result
	
	private new (R result, Exception e) {
		this.e = e
		this.result = result
	}
	
	def static <R> Try<R> completedSuccessfully(R result) {
		new Try(result, null)
	}
	
	def static <R> Try<R> completedExceptionally(Exception e) {
		new Try(null, e)
	}
	
	// maybe 
	def static <I extends AutoCloseable,R> tryWith(()=>I resourceProvider, (I)=>R provider) {
		try {
			val resource = resourceProvider.apply
			try {
				val result = provider.apply(resource);
				new Try(result, null)
			} finally {
				resource.close
			}
		} catch(Exception e) {
			new Try(null, e);
		}
	}
	
	def static <R> Try<R> doTry(()=>R provider) {
		try {
			val result = provider.apply
			new Try(result, null)
		} catch(Exception e) {
			new Try(null, e)
		}
	}
	
	def static <R> Try<R> flatTry(()=>Try<R> provider) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions of class {@code E}. If recovery fails with exception
	 * it will be thrown by this method.
	 */
	def <E> Try<R> recover(Class<E> exceptionType, (E)=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions of class {@code E}. If recovery fails with
	 * exception the returned Try will hold the exception
	 */
	def <E> Try<R> tryRecover(Class<E> exceptionType, (E)=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions. If recovery fails with an exception, the exception 
	 * will be thrown by this method.
	 */
	def Try<R> recover((Exception)=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions
	 */
	def Try<R> tryRecover((Exception)=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions or {@code null} result values with value provided by {@code recovery}.
	 * If {@code recovery} fails with an exception it will be thrown by this method. If the result
	 * of {@code recovery} is {@code null}, then this method will return {@code null}.
	 */
	def R recoverEmpty(()=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Recovers exceptions or {@code null} result values with value {@code recovery}.
	 */
	def R recoverEmpty(R recovery) {
		result ?: recovery
	}
	
	/**
	 * Recovers exceptions or {@code null} result values with value {@code recovery}.
	 * If recovery fails with an exception a failed {@code Try} is returned.
	 */
	def Try<R> tryRecoverEmpty(()=>R recovery) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Provides exception of type {@code E} to {@code handler} if this {@code Try} failed with
	 * an exception of type {@code E}. Returns this {@code Try} unchanged.
	 * @return same instance as {@code this}.
	 */
	def <E> Try<R> ifException(Class<E> exceptionType, (E)=>void handler){
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Provides exception to {@code handler} if this {@code Try} failed with
	 * an exception. Returns this {@code Try} unchanged.
	 * @return same instance as {@code this}.
	 */
	def <E> Try<R> ifException((Exception)=>void handler){
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Calls the given {@code handler} with the result value if the Try 
	 * completed with a non {@code null} result value.
	 */
	def Try<R> ifResult((R)=>void handler){
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * If operation was successful but returned {@code null} value.
	 */
	def Try<R> ifEmptyResult(()=>void handler){
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Calls {@code action} with the result of this try, if the Try
	 * holds a successful result and is not {@code null}.
	 * @param action operation to be performed if this Try holds a result that
	 *  is not {@code null}.
	 * @return Try wrapping the result of the {@code action} if it completes successful,
	 *   or holding an exception if the operation throws 
	 */
	def <U> Try<U> thenTry((R)=>U action) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	def <U, I extends AutoCloseable> Try<U> thenTryWith(()=>I resourceProducer,(I,R)=>U action) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	def <U> Try<U> thenFlatTry((R)=>Try<U> action) {
		throw new UnsupportedOperationException("Not implemented yet")
	}
	
	/**
	 * Returns empty optional if Try completed exceptionally or with a
	 * {@code null} value. Otherwise returns an optional with the computed
	 * result value present.
	 */
	def Optional<R> get() {
		if(e !== null) {
			Optional.empty
		} else {
			Optional.ofNullable(result)
		}
	}
	
	/**
	 * Returns result value on successful computation (even when the result
	 * value was {@code null}) or {@code null} if an exception was thrown.
	 */
	def R getOrNull() {
		if(e !== null) {
			null
		} else {
			result
		}
	}
	
	/**
	 * Returns result value on successful computation with a result value was 
	 * not {@code null}. If the the operation failed with an exception, this exception
	 * will be re-thrown. If the result was {@code null} a {@link NoSuchElementException}
	 * will be thrown
	 */
	def R getOrThrow() throws NoSuchElementException {
		if(e !== null) {
			throw e
		}
		if(result !== null) {
			result
		} else {
			throw new NoSuchElementException
		}
	}
}