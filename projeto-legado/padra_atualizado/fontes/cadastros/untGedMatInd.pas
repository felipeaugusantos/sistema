unit untGedMatInd;

interface

uses
  SysUtils, Classes, DB,   Uni, StrUtils, Variants, untZClient, DateUtils;

function fGravaGedMat(Var strAutInc: String;
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
                      strObs005: String = '';
                      strObs006: String = '';
                      strObs007: String = '';
                      dtaDtaFor : TDate = 0): Boolean;

function fGravaDedMat(strSeqGer: string;
                      intSeQuen: Integer;
                      strSeqIte,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino:String;
                      fltQtdIte,
                      fltPerTol:Double;
                      strCodFas: String): Boolean; //custo calculado

function fRetornaSequencialItemEstruturaDF(strCodIte: String): Integer;
function fGravaGedAna(strAutoInc : String; cdsGedAna : TZClient) : Boolean;

implementation

uses untFuncoesSimples;

function fGravaGedMat(var strAutInc: String;
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
                      strObs005: String = '';
                      strObs006: String = '';
                      strObs007: String = '';
                      dtaDtaFor : TDate = 0): Boolean;
  Var
    qryGerMat: TUniQuery;
begin
  Result := True;

  Try
    strAutInc := fRetAutoIncrem('GEDMAT',strCodEmp);

    If fEmptyStr(strCodFor) Then
      strCodFor := IntToStr(fRetornaSequencialItemEstruturaDF(strCodIte));

    qryGerMat := fCriarQuery('SELECT * FROM GEDMAT WHERE FALSE', nil);
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
      FieldByName('GMT_REFERE').AsString := strRefere;
      FieldByName('GMT_OBS001').AsString := strObs001;
      FieldByName('GMT_OBS002').AsString := strObs002;
      FieldByName('GMT_OBS003').AsString := strObs003;
      FieldByName('GMT_OBS004').AsString := strObs004;
      FieldByName('GMT_OBS005').AsString := strObs005;
      FieldByName('GMT_OBS006').AsString := strObs006;
      FieldByName('GMT_OBS007').AsString := strObs007;
      FieldByName('GMT_PESREA').AsFloat  := fltPesRea;

      if DateTimeToUnix(dtaDtaFor )<=0 then
        FieldByName('GMT_DTAFOR').AsDateTime := VS_Date
      Else
        FieldByName('GMT_DTAFOR').AsDateTime := dtaDtaFor;

      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryGerMat.Cancel;
      pMensagensErro(E.Message, '[fGravaGedMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGerMat);
end;



function fGravaDedMat(strSeqGer: string;
                      intSeQuen: Integer;
                      strSeqIte,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino:String;
                      fltQtdIte,
                      fltPerTol:Double;
                      strCodFas: String): Boolean;
  Var
    strAutInc: String;
    qryDetMat: TUniQuery;
begin

  Result := True;

  Try

    strAutInc := fRetAutoIncrem('DEDMAT',strCodEmp);

    qryDetMat := fCriarQuery('SELECT * FROM DEDMAT WHERE FALSE', nil);
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
      pMensagensErro(E.Message, '[fGravaDedMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryDetMat);
end;

function fRetornaSequencialItemEstruturaDF(strCodIte: String): Integer;
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
        SQL.Add('  GEDMAT                         ');
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
        pMensagensErro(E.Message, '[fRetornaSequencialItemEstruturaDF]');
      end;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;


function fGravaGedAna(strAutoInc : String; cdsGedAna : TZClient) : Boolean;
  Var
    qryGedAna : TUniQuery;
Begin
  Try
    Try
      Result := True;
      qryGedAna:= fCriaQuery;
      With qryGedAna, SQL Do
      Begin
        Close;
        Clear;
        Add(' INSERT INTO GEDANA (AUTOINCREM, ');
        Add('                     GAN_CODANA, ');
        Add('                     GAN_LIMMIN, ');
        Add('                     GAN_LIMMAX, ');
        Add('                     GAN_DESRES, ');
        Add('                     GAN_SEQGMT) ');
        Add(' VALUES             (:AUTINC,    ');
        Add('                     :CODANA,    ');
        Add('                     :LIMMIN,    ');
        Add('                     :LIMMAX,    ');
        Add('                     :DESRES,    ');
        Add('                     :SEQGMT)    ');

        ParamByName('SEQGMT').AsString := strAutoInc;

        cdsGedAna.First;
        While not cdsGedAna.Eof Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('GEDANA', VS_strCodEmp);
          ParamByName('CODANA').AsString := cdsGedAna.FieldByName('GAN_CODANA').AsString;
          ParamByName('LIMMIN').AsFloat  := cdsGedAna.FieldByName('GAN_LIMMIN').AsFloat;
          ParamByName('LIMMAX').AsFloat  := cdsGedAna.FieldByName('GAN_LIMMAX').AsFloat;
          ParamByName('DESRES').AsString := cdsGedAna.FieldByName('GAN_DESRES').AsString;
          ExecSQL;

          cdsGedAna.Next;
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
    FreeAndNil(qryGedAna);
  End;
End;

end.

