// Autogenerated from Pigeon (v6.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Pigeon {
  @NonNull private static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<>(3);
    errorList.add(exception.toString());
    errorList.add(exception.getClass().getSimpleName());
    errorList.add("Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorList;
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonUserDetails {
    private @NonNull String userId;
    public @NonNull String getUserId() { return userId; }
    public void setUserId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"userId\" is null.");
      }
      this.userId = setterArg;
    }

    private @NonNull String phoneNumber;
    public @NonNull String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"phoneNumber\" is null.");
      }
      this.phoneNumber = setterArg;
    }

    /**Constructor is private to enforce null safety; use Builder. */
    private PigeonUserDetails() {}
    public static final class Builder {
      private @Nullable String userId;
      public @NonNull Builder setUserId(@NonNull String setterArg) {
        this.userId = setterArg;
        return this;
      }
      private @Nullable String phoneNumber;
      public @NonNull Builder setPhoneNumber(@NonNull String setterArg) {
        this.phoneNumber = setterArg;
        return this;
      }
      public @NonNull PigeonUserDetails build() {
        PigeonUserDetails pigeonReturn = new PigeonUserDetails();
        pigeonReturn.setUserId(userId);
        pigeonReturn.setPhoneNumber(phoneNumber);
        return pigeonReturn;
      }
    }
    @NonNull ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(userId);
      toListResult.add(phoneNumber);
      return toListResult;
    }
    static @NonNull PigeonUserDetails fromList(@NonNull ArrayList<Object> list) {
      PigeonUserDetails pigeonResult = new PigeonUserDetails();
      Object userId = list.get(0);
      pigeonResult.setUserId((String)userId);
      Object phoneNumber = list.get(1);
      pigeonResult.setPhoneNumber((String)phoneNumber);
      return pigeonResult;
    }
  }
  private static class UserApiCodec extends StandardMessageCodec {
    public static final UserApiCodec INSTANCE = new UserApiCodec();
    private UserApiCodec() {}
    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return PigeonUserDetails.fromList((ArrayList<Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value)     {
      if (value instanceof PigeonUserDetails) {
        stream.write(128);
        writeValue(stream, ((PigeonUserDetails) value).toList());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface UserApi {
    @NonNull PigeonUserDetails getUserDetails();

    /** The codec used by UserApi. */
    static MessageCodec<Object> getCodec() {
      return       UserApiCodec.INSTANCE;    }
    /**Sets up an instance of `UserApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, UserApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.UserApi.getUserDetails", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            ArrayList wrapped = new ArrayList<>();
            try {
              PigeonUserDetails output = api.getUserDetails();
              wrapped.add(0, output);
            }
            catch (Error | RuntimeException exception) {
              ArrayList<Object> wrappedError = wrapError(exception);
              wrapped = wrappedError;
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
}
