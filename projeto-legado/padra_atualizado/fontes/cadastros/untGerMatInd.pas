unit untGerMatInd;

interface

uses
  SysUtils, Classes, DB,   Uni, StrUtils, Variants, untZClient, DateUtils;

function fGravaGerMat(Var strAutInc: String;
                      strCodEmp,
                      strCodIte,
                      strCodCor: String;
                      Var strCodFor: String;
                      strRefere,
                      strObs001,
                      strObs002,
                      strObs003,
                      strObs004,
                      strStatus: String;
                      fltPesRea: Double;
                      dtaDtaCad,
                      hraHraCad,
                      dtaDtaAlt,
                      hraHraAlt: TDateTime;
                      blnForEsp : Boolean = False;
                      strObs005 : String = '';
                      strObs006 : String = '';
                      strObs007 : String = '';
                      dtaDtaFor : TDate = 0;
                      strDesPro : String = '';
                      fltCapacidadeMaxima : real = 0;
                      strOpeExt : String = '';
                      strObsExt : String = '';
                      strHreXin : String = '';
                      strHreXfn : String = '';
                      strRosCa_ : String = '';
                      strVelPic : String = ''): Boolean;


function fGravaDetMat(strSeqGer: string;
                      intSeQuen: Integer;
                      strSeqIte,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino:String;
                      fltQtdIte:Double;
                      fltPerTol:Double;
                      strCodFas: String): Boolean; //custo calculado

function fGravaGeiEpi(strAutoInc : String; cdsGeiEpi : TZClient) : Boolean;
function fGravaGeiAna(strAutoInc : String; cdsGeiAna : TDataSet) : Boolean;

function fRetornaSequencialItemEstrutura(strCodIte: String): Integer;

implementation

uses untFuncoesSimples;

function fGravaGerMat(var strAutInc: String;
                      strCodEmp,
                      strCodIte,
                      strCodCor: String;
                      Var strCodFor: String;
                      strRefere,
                      strObs001,
                      strObs002,
                      strObs003,
                      strObs004,
                      strStatus: String;
                      fltPesRea: Double;
                      dtaDtaCad,
                      hraHraCad,
                      dtaDtaAlt,
                      hraHraAlt: TDateTime;
                      blnForEsp : Boolean = False;
                      strObs005 : String = '';
                      strObs006 : String = '';
                      strObs007 : String = '';
                      dtaDtaFor : TDate = 0;
                      strDesPro : String = '';
                      fltCapacidadeMaxima : real = 0;
                      strOpeExt : String = '';
                      strObsExt : String = '';
                      strHreXin : String = '';
                      strHreXfn : String = '';
                      strRosCa_ : String = '';
                      strVelPic : String = ''): Boolean;

  Var
    qryGerMat: TUniQuery;
begin
  Result := True;

  Try
    strAutInc := fRetAutoIncrem('GEIMAT',strCodEmp);

    If fEmptyStr(strCodFor) Then
      strCodFor := IntToStr(fRetornaSequencialItemEstrutura(strCodIte));

    qryGerMat := fCriarQuery('SELECT * FROM GEIMAT WHERE FALSE', nil);
    With qryGerMat Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('AUTOINCREM').AsString  := strAutInc;
      FieldByName('GMT_CODEMP').AsString  := strCodEmp;
      FieldByName('GMT_CODITE').AsString  := strCodIte;
      FieldByName('GMT_CODCOR').AsString  := strCodCor;
      FieldByName('GMT_FORMUL').AsInteger := StrToInt(strCodFor);
      FieldByName('GMT_STATUS').AsString  := strStatus;
      FieldByName('GMT_REFERE').AsString  := strRefere;
      FieldByName('GMT_OBS001').AsString  := strObs001;
      FieldByName('GMT_OBS002').AsString  := strObs002;
      FieldByName('GMT_OBS003').AsString  := strObs003;
      FieldByName('GMT_OBS004').AsString  := strObs004;
      FieldByName('GMT_OBS005').AsString  := strObs005;
      FieldByName('GMT_OBS006').AsString  := strObs006;
      FieldByName('GMT_OBS007').AsString  := strObs007;
      FieldByName('GMT_PESREA').AsFloat   := fltPesRea;
      FieldByName('GMT_FORESP').AsBoolean := blnForEsp;
      FieldByName('GMT_OBS008').AsString  := strDesPro;
      FieldByName('GMT_CAPMAX').AsFloat   := fltCapacidadeMaxima;
      If fEmptyStr(strLoginUsuarioLogado) Then
        FieldByName('GMT_CODOPE').Value  := Null
      Else
        FieldByName('GMT_CODOPE').AsString  := strLoginUsuarioLogado;

      If dtaDtaCad = 0 Then
        FieldByName('GMT_DTACAD').AsDateTime := VS_Date
      Else
        FieldByName('GMT_DTACAD').AsDateTime := dtaDtaCad;

      If hraHraCad = 0 Then
        FieldByName('GMT_HRACAD').AsDateTime := fNow
      Else
        FieldByName('GMT_HRACAD').AsDateTime := hraHraCad;

      If dtaDtaAlt = 0 Then
        FieldByName('GMT_DTAALT').Clear
      Else
        FieldByName('GMT_DTAALT').AsDateTime := dtaDtaAlt;

      If hraHraAlt = 0 Then
        FieldByName('GMT_HRAALT').Clear
      Else
        FieldByName('GMT_HRAALT').AsDateTime := hraHraAlt;

      if DateTimeToUnix(dtaDtaFor )<=0 then
        FieldByName('GMT_DTAFOR').AsDateTime := VS_Date
      Else
        FieldByName('GMT_DTAFOR').AsDateTime := dtaDtaFor;

      If fCfgSis('EXMOPI', varBoolean) Then
      Begin

        If fEmptyStr(strOpeExt) Then
          FieldByName('GMT_OPEEXT').Value := Null
        Else
          FieldByName('GMT_OPEEXT').AsString  := strOpeExt;

        FieldByName('GMT_OBSEXT').AsString  := strObsExt;

        If(fEmptyTime(strHreXin)) Then
          FieldByName('GMT_HREXIN').Value  := Null
        Else
          FieldByName('GMT_HREXIN').Value  := strToTime(strHreXin);

        If(fEmptyTime(strHreXfn)) Then
          FieldByName('GMT_HREXFN').Value  := Null
        Else
          FieldByName('GMT_HREXFN').Value  := strToTime(strHreXfn);

        FieldByName('GMT_ROSCA_').AsString := strRosCa_;
        FieldByName('GMT_VELPIC').AsString := strVelPic;
      End;


      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryGerMat.Cancel;
      pMensagensErro(E.Message, '[fGravaGerMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGerMat);
end;



function fGravaDetMat(strSeqGer: string;
                      intSeQuen: Integer;
                      strSeqIte,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino:String;
                      fltQtdIte:Double;
                      fltPerTol:Double;
                      strCodFas: String): Boolean;
  Var
    strAutInc: String;
    qryDetMat: TUniQuery;
begin

  Result := True;

  Try

    strAutInc := fRetAutoIncrem('DEIMAT',strCodEmp);

    qryDetMat := fCriarQuery('SELECT * FROM DEIMAT WHERE FALSE', nil);
    With qryDetMat Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('AUTOINCREM').AsString  := strAutInc;
      FieldByName('DMT_SEQGER').AsString  := strSeqGer;
      FieldByName('DMT_SEQUEN').AsInteger := intSeQuen;
      FieldByName('DMT_SEQITE').AsString  := strSeqIte;
      FieldByName('DMT_CODEMP').AsString  := strCodEmp;
      FieldByName('DMT_ITESUB').AsVariant := IIF(strIteSub = '', Null, strIteSub);
      FieldByName('DMT_DESCRI').AsVariant := IIF(strDescri = '', Null, strDescri);
      FieldByName('DMT_DESPCA').AsVariant := IIF(strDestino = '', Null, strDestino);
      FieldByName('DMT_CODFAS').AsVariant := IIF(strCodFas = '', Null, strCodFas);
      FieldByName('DMT_QTDITE').AsFloat   := fltQtdIte;
      FieldByName('DMT_PERTOL').AsFloat   := fltPerTol;
      Post;

    End;


  Except
    On E: Exception Do
    Begin
      qryDetMat.Cancel;
      pMensagensErro(E.Message, '[fGravaDetMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryDetMat);
end;

function fGravaGeiEpi(strAutoInc : String; cdsGeiEpi : TZClient):Boolean;
  Var
    qryGeiEpi : TUniQuery;
Begin
  Try
    Try
      Result := True;
      qryGeiEpi := fCriaQuery;
      With qryGeiEpi, SQL Do
      Begin
        Close;
        Clear;
        Add(' INSERT INTO GEIEPI (AUTOINCREM, ');
        Add('                     GEP_CODEPI, ');
        Add('                     GEP_TIPUSO, ');
        Add('                     GEP_OBSERV, ');
        Add('                     GEP_SEQGMT) ');
        Add(' VALUES             (:AUTINC,    ');
        Add('                     :CODEPI,    ');
        Add('                     :TIPUSO,    ');
        Add('                     :OBSERV,    ');
        Add('                     :SEQGMT)    ');

        ParamByName('SEQGMT').AsString := strAutoInc;

        cdsGeiEpi.First;
        While not cdsGeiEpi.Eof Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('GEIEPI', VS_strCodEmp);
          ParamByName('CODEPI').AsString := cdsGeiEpi.FieldByName('GEP_CODEPI').AsString;
          ParamByName('TIPUSO').AsString := cdsGeiEpi.FieldByName('GEP_TIPUSO').AsString;
          ParamByName('OBSERV').AsString := cdsGeiEpi.FieldByName('GEP_OBSERV').AsString;

          ExecSQL;

          cdsGeiEpi.Next;
        End;

      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    End;

  Finally
    FreeAndNil(qryGeiEpi);
  End;
End;


function fGravaGeiAna(strAutoInc : String; cdsGeiAna : TDataSet) : Boolean;
  Var
    qryGeiAna : TUniQuery;
Begin
  Try
    Try
      Result := True;
      qryGeiAna:= fCriaQuery;
      With qryGeiAna, SQL Do
      Begin
        Close;
        Clear;
        Add(' INSERT INTO GEIANA (AUTOINCREM, ');
        Add('                     GAN_CODANA, ');
        Add('                     GAN_LIMMIN, ');
        Add('                     GAN_LIMMAX, ');
        Add('                     GAN_DESRES, ');
        Add('                     GAN_INFOAB, ');
        Add('                     GAN_SEQGMT) ');



        Add(' VALUES             (:AUTINC,    ');
        Add('                     :CODANA,    ');
        Add('                     :LIMMIN,    ');
        Add('                     :LIMMAX,    ');
        Add('                     :DESRES,    ');
        Add('                     :INFOAB,    ');
        Add('                     :SEQGMT)    ');

        ParamByName('SEQGMT').AsString := strAutoInc;

        cdsGeiAna.First;
        While not cdsGeiAna.Eof Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('GEIANA', VS_strCodEmp);
          ParamByName('CODANA').AsString := cdsGeiAna.FieldByName('GAN_CODANA').AsString;
          ParamByName('LIMMIN').AsFloat  := cdsGeiAna.FieldByName('GAN_LIMMIN').AsFloat;
          ParamByName('LIMMAX').AsFloat  := cdsGeiAna.FieldByName('GAN_LIMMAX').AsFloat;
          ParamByName('INFOAB').AsString := cdsGeiAna.FieldByName('GAN_INFOAB').AsString;
          ParamByName('DESRES').AsString := cdsGeiAna.FieldByName('GAN_DESRES').AsString;
          ExecSQL;

          cdsGeiAna.Next;
        End;

      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    End;

  Finally
    FreeAndNil(qryGeiAna);
  End;
End;

function fRetornaSequencialItemEstrutura(strCodIte: String): Integer;
var
  qryCon: TUniQuery;
begin
  Try
    Try

      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                           ');
        SQL.Add('  IFNULL(MAX(GMT_FORMUL),0) AS ID');
        SQL.Add('FROM                             ');
        SQL.Add('  GEIMAT                         ');
        SQL.Add('WHERE                            ');
        SQL.Add('  GMT_CODITE = :CODITE           ');

        ParamByName('CODITE').AsString := strCodIte;

        Open;
        Result := FieldByName('ID').AsInteger + 1;
      End;

    Except
      on E: Exception do
      begin
        Result := 0;
        pMensagensErro(E.Message, '[fRetornaSequencialItemEstrutura]');
      end;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

end.
