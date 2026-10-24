unit untFuncoesGenerica;

interface

Uses
{$IFDEF LINUX}

{$ELSE}
  Forms, Controls,
{$ENDIF}
  SysUtils, iniFiles, untIDataSet, IdHash, IdHashMessageDigest;

Type
  TPais = (opcBrasil, opcParaguai);

Type
  TCgcCpf = (C_G_C_, C_P_F_);

Type
  TCaptionCgcCpf = (capC_G_C_, capC_P_F_, capGERAL_);

function fFormataFone(strFone: String): String;
function fRetMascaraFone(opcPais: TPais): String;
function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf): String;
function fRetCaptionRG(opcPais: TPais): String;
function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
function fTiraCaracEspeciaisParenteses(strTexto: String): String;
function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
function fSetaPais: TPais;
function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
function fRetSiglaPais(opcPais: TPais): String;
function fRetSiglaPaisAtual: String;
function fPodeValidarCgcCpf(FPais: TPais): Boolean;
function fMostraTipoCgcCpf(FPais: TPais): Boolean;
function fVerificarNovaFormulaMovimentada(const strSql: string; const arrParametros: array of Variant): Boolean;
function GetMD5(const strTexto: string): string;
{$IFNDEF LINUX}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
{$ENDIF}
function fEntraCons(strCodigo: String): Boolean;

procedure pGravaCfgPais(strSigPai: String);

function fNow: TDateTime;

implementation

uses untAutcomTintaFactory, System.Variants;

function fFormataFone(strFone: String): String;
Begin
  strFone := Trim(fTiraCaracEspeciaisParenteses(strFone));
  If Length(strFone) > 6 Then
  Begin
    Insert('-',strFone,Length(strFone)-3);

    If Length(strFone) > 8 Then
    Begin
      Insert(')',strFone,3);
      strFone := '('+ strFone;
    End;
  End;
  Result := strFone;
End;

function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  Var
    iniArqIni: TIniFile;
Begin
  iniArqIni := TIniFile.Create(strPath + '\opcoes.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;

End;

function fSetaPais: TPais;
Var
  strPais: String;
Begin
  strPais := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(ParamStr(0))));
 
  If SameText(strPais, 'PAR') Then
    Result := opcParaguai
  Else
    Result := opcBrasil;

End;

function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
Begin
  If strCgcCpf = '1' Then
    Result := C_G_C_
  Else
    Result := C_P_F_;
End;

function fRetMascaraFone(opcPais: TPais): String;
Begin
  case opcPais Of
    opcBrasil  : Result := '!\(99\)9999-9999;0;_';
    opcParaguai: Result := '' ;
  end;
End;

function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf): String;
Begin
  Result := '';
  
  case opcPais Of
    opcBrasil: Begin
                 Case opcCgcCpf Of
                   C_G_C_: Result := '>aa\.aaa\.aaa/aaaa-99;0;';
                   C_P_F_: Result := '999.999.999-99;0;';
                 End;
               End;

    opcParaguai: Result := '';
  end;

End;

function fRetCaptionRG(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'R.G.:';
    opcParaguai: Result := 'CI:';
  end;
End;

function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
Begin
  Case opcPais Of
    opcBrasil  : Case opcCgcCpf Of
                   capC_G_C_: Result := 'CNPJ:';
                   capC_P_F_: Result := 'CPF:';
                   capGeral_: Result := '1-CNPJ/2-CPF:';
                 End;

    opcParaguai: Result := 'RUC:';
  end;
End;

procedure pGravaCfgPais(strSigPai: String);
Begin
  fArqIniGeral(1, 'PAIS', 'SIGLA', strSigPai, Pchar(ExtractFilePath(ParamStr(0))));
End;

function fRetSiglaPais(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'BRA';
    opcParaguai: Result := 'PAR';
  End;
End;

function fRetSiglaPaisAtual: String;
Begin
  Result := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(ParamStr(0))));
End;

function fPodeValidarCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fMostraTipoCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fVerificarNovaFormulaMovimentada(const strSql: string; const arrParametros: array of Variant): Boolean;
const
  arrTabelas : array[0..4] of string = ('TINDET', 'TINDOR', 'MOVDET', 'FATDOR', 'NOTDET');
  arrPrefixos: array[0..4] of string = ('DET', 'FDO', 'DET', 'FDO', 'DET');
var
  intCont: Integer;
  intParametros: Integer;
  qryGen: IDataSet;
begin
  Result := True;
  qryGen := nil;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      for intCont := 0 to Length(arrTabelas) - 1 do
      begin
        qryGen.Close;
        qryGen.SQL := Format(strSql, [arrTabelas[intCont], arrPrefixos[intCont]]);
        for intParametros := 0 to Length(arrParametros) - 1 do
        begin
          qryGen.Params(intParametros).Value := arrParametros[intParametros];
        end;
        qryGen.Open;

        Result := qryGen.FieldByName('QTD').AsInteger > 0;
        if Result then
          Exit;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
   // if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function GetMD5(const strTexto: string): string;
var
//  valor: T4x4LongWordRecord;
  idHash128: TIdHashMessageDigest5;
begin
  Try
    Try
      idHash128 := TIdHashMessageDigest5.Create;
//      valor := idHash128.HashValue(strTexto);
//      Result := idHash128.AsHex(valor);
      Result := idHash128.HashStringAsHex(strTexto);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(idHash128) then FreeAndNil(idHash128);
  End;
end;

{$IFNDEF LINUX}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
begin
  If Not Assigned(SenderUnico) Then Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;
      Except

      End;
    End;
  Except

  End;
end;
{$ENDIF}

function fEntraCons(strCodigo: String): Boolean;
begin
  Result := (Pos('/', strCodigo) > 0) Or (Pos('?', strCodigo) > 0);
end;

function fNow: TDateTime;
  Var
    qryGenTmp: IDataSet;
begin
  Try
    qryGenTmp := TAutcomTintaFactory.Get.fGetDataSet;
    Try
      qryGenTmp.SQL := 'SELECT CURRENT_DATE() AS DATA, CURRENT_TIME() AS HORA';
      qryGenTmp.Open;

      Try
        Result := qryGenTmp.FieldByName('DATA').AsDate + VarToDateTime(qryGenTmp.FieldByName('HORA').Value);
      Except
        Result := qryGenTmp.FieldByName('DATA').AsDate + Time();
      End;

      qryGenTmp.Close;
    Except
      Result := 0;
    End;
  Finally
//    FreeAndNil(qryGenTmp);
  End;
end;

end.
