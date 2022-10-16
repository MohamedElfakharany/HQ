const mainURL = 'https://hq.orcav.com/api';

const authURL = '$mainURL/auth';

const coreURL = '$mainURL/core';

const testURL = '$mainURL/test';

const profileURL = '$mainURL/profile';

      ///Auth

const registerURL = '$authURL/register';

const loginURL = '$authURL/login';

const verificationURL = '$authURL/verify';

const completeProfileURL = '$authURL/complete-profile';

const createTokenURL = '$authURL/create-token';

const resetPasswordURL = '$authURL/reset-password';

      ///Core

const countryURL = '$coreURL/countries';

const cityURL = '$coreURL/cities';

const branchURL = '$coreURL/branches';

const relationsURL = '$coreURL/relations';

const slidersURL = '$coreURL/sliders';

      ///Tests

const categoriesURL = '$testURL/categories';

const testsURL = '$testURL/tests';

const offersURL = '$testURL/offers';

      ///Profile

const getProfileURL = '$profileURL/get-profile';

const editProfileURL = '$profileURL/edit-profile';

const getTermsPrivacyURL = '$profileURL/terms-privacy';

const changeLocationURL = '$profileURL/change-location';

const changePasswordURL = '$profileURL/change-password';

      ///Profile
              ///medical-inquiries


              ///families
const familiesURL = '$profileURL/families';

const createMemberURL = '$familiesURL/create';

const editMemberURL = '$familiesURL/:familyId/edit';

const deleteMemberURL = '$familiesURL/:familyId/delete';

              ///addresses




      ///Reservations