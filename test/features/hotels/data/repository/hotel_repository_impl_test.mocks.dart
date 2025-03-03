// Mocks generated by Mockito 5.4.4 from annotations
// in hotel_booking/test/features/hotels/data/repository/hotel_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:hotel_booking/core/network/api_client.dart' as _i2;
import 'package:hotel_booking/features/hotels/data/datasource/remote_data_source.dart'
    as _i4;
import 'package:hotel_booking/features/hotels/data/models/hotel_response.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApiClient_0 extends _i1.SmartFake implements _i2.ApiClient {
  _FakeApiClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHotelResponse_1 extends _i1.SmartFake implements _i3.HotelResponse {
  _FakeHotelResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock implements _i4.RemoteDataSource {
  MockRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ApiClient get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeApiClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.ApiClient);

  @override
  _i5.Future<_i3.HotelResponse> getHotels() => (super.noSuchMethod(
        Invocation.method(
          #getHotels,
          [],
        ),
        returnValue: _i5.Future<_i3.HotelResponse>.value(_FakeHotelResponse_1(
          this,
          Invocation.method(
            #getHotels,
            [],
          ),
        )),
      ) as _i5.Future<_i3.HotelResponse>);
}
