package tn.esprit.spring.config;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class PerformanceAspect {
	

	private static final Logger logger = LogManager.getLogger(PerformanceAspect.class);

	@Around("execution(int tn.esprit.spring.services.*.*(..))")
    public Object profile(ProceedingJoinPoint pjp) throws Throwable {
            long start = System.currentTimeMillis();
            Object out=pjp.proceed();
            long elapsedTime = System.currentTimeMillis() - start;
            logger.info("Method execution time: " + elapsedTime + " milliseconds.");
            return out;
    }

}
