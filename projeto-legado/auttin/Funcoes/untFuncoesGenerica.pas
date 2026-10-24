unit untFuncoesGenerica;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  untGTinForTipos,
  untSaldoPedidoCompra,
  untIFatReservaSaldo,
  untTFatReservaSaldo,
  untIFatEntregaFutura,
  untTFatEntregaFutura,
  Shared.Functions.Funcoes.Faturamento,
  Faturamento.Connections.Functions,
{$ELSE}
  Forms, DBGrids, Windows,
{$ENDIF}
  SysUtils, iniFiles, Uni, StrUtils, MaskUtils,
  System.RegularExpressions, System.Classes,
  untTypesSistema, Math, Data.DB;

{$IFDEF LINUX}
Type
  TForMulTinDetArray = untGTinForTipos.TForMulTinDetArray;
  TBaixaPigmentosArray = untGTinForTipos.TBaixaPigmentosArray;
{$ENDIF}

Type
  TPais = (opcBrasil, opcParaguai);

Type
  TCgcCpf = (C_G_C_, C_P_F_);

Type
  TCaptionCgcCpf = (capC_G_C_, capC_P_F_, capGERAL_);

function fFormataFone(strFone: String): String;
function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil): String;
function fRetMascaraFone(opcPais: TPais): String;
function fRetMascaraFonePais: String;

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

function fAcertaMaskTel(strFone: String): String;
function fValidaTelefone(strFone: String): Boolean;
function fValidaCelular(strNumero: string): Boolean;

procedure pGravaCfgPais(strSigPai: String);
procedure pGravaCfgComCus(intValCfg : Integer);
procedure pGravaCfgCertificadoDigital(strCerDig: String);

{$IFNDEF LINUX}
procedure pAjustaLarguraDasColunas(DBGrid: TDBGrid);
{$ENDIF}

function fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis(const strCodEmp : String = '') : Boolean;

function fGravaLogContEst(strCodOpe, strCodIte, strNumLot: String; fltSalCon, fltSalMl: Double; strAutInc: String = ''): Boolean;

function fGravaLogLocFisica(strCodIte,
                            strInfAnt,
                            strInfNov: String;
                            intTipAlt: Integer;
                            strNumLote: String;
                            strCodOpe: String = ''): Boolean;

function fConferenciaDepoisDaEntrada : Boolean;
function fRetEmpresasWms(blnUtiWms: Boolean): String;
function fRetSaldosEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''; blnIgnorarLote: Boolean = False): Double;
function fRetSaldosMLEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''): Double;
function fItemMarmore(strCodIte: String): Boolean;
function fItemLoteChapa(strCodIte, strOpcDoc : String) : Boolean;

function GetSQLReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True): String;
procedure ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True);

function fArrCodigosToText(arrCodigos: TConsultasArray): String;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;

function fUsaSat(strCodEmp : String = '') : Boolean;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal : Boolean = True; strEmpSalRes : String = ''): Boolean;

{$IFDEF LINUX}
function fRetForFilialTodos(blnLista: Boolean = False): String;
{$ENDIF}

{$IFDEF LINUX}
function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False;
                                 blnFaturamento: Boolean = True; strNumLot : String = '';
                                 blnConsiderarPedidos : Boolean = True;
                                 strCodEmp: String = ''; strNumPedAlt: String = '';
                                 blnConsiderarPedidoCompraPendente: Boolean = False;
                                 blnConsiderarCfgCalSal: Boolean = True;
                                 blnConsiderarOrdemProducao: Boolean = True;
                                 blnInformaSaldoGeralDisponivel: Boolean = False): Double;
{$ENDIF}

{$IFDEF LINUX}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
{$ENDIF}

function fEhAdministrador(strCodOpe: String): Boolean;

function fGetSQLEstruturaPai(strCodEmp: String): String;
function fRetEmpCarregamentoItem(strCodIte: String): String;
function fRetMotivoVendasPerdidas(Const strCodMot: String): String;

{$IFDEF LINUX}
function fEhOuCompoeEstrutura(strCodIte: String; strCodEmp: String=''): TItemEstru;
{$ENDIF}

{$IFDEF LINUX}
function fEhItemServico(strCodIte: String; blnEntradaMercadoria : Boolean = False): Boolean;
{$ENDIF}

implementation

{$IFNDEF LINUX}
uses untFuncoesSimples;
{$ENDIF}

function fFormataFone(strFone: String): String;
Begin
  strFone := fFormataFonePais(Trim(fTiraCaracEspeciaisParenteses(strFone)),fSetaPais);
  Result  := strFone;
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
  //strPais := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));

  strPais := fCfgSis('SIGPAI', varString);

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
    opcBrasil  : Result := '!\(99\)99999-9999;0;_';
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
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  //fArqIniGeral(1, 'PAIS', 'SIGLA', strSigPai, Pchar(ExtractFilePath(Application.ExeName)));

  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsString := strSigPai;
      ParamByName('CODCFG').AsString := 'CFG_SIGPAI';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

End;

procedure pGravaCfgComCus(intValCfg : Integer);
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsInteger := intValCfg;
      ParamByName('CODCFG').AsString  := 'CFG_COMCUS';
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

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
  //Result := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));
  Result := fCfgSis('SIGPAI', varString);
End;

function fPodeValidarCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fMostraTipoCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fRetMascaraFonePais: String;
Begin
  Result := fRetMascaraFone(fSetaPais);
end;

function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil): String;
Begin
  If FPais = opcParaguai Then
    Result := Trim(fTiraCaracEspeciaisParenteses(strTelefo))
  Else
    If Not (fEmptyStr(strTelefo)) Then
      Result := FormatMaskText(fRetMascaraFone(FPais),Copy(strTelefo,1,11))
    Else
      Result := '';
End;

function fAcertaMaskTel(strFone: String): String;
begin
  strFone := AnsiReplaceStr(strFone, '(', '');
  strFone := AnsiReplaceStr(strFone, ')', '');
  strFone := AnsiReplaceStr(strFone, ' ', '');
  strFone := AnsiReplaceStr(strFone, '-', '');

  if (Length(strFone) = 10) then
    Result := Copy(strFone,1,2) + ' ' + Copy(strFone,3,8)
  Else
    Result := strFone;
end;

function fValidaTelefone(strFone: String): Boolean;
  Var
    intChar: Integer;
begin

  Result := True;

  strFone := AnsiReplaceStr(strFone, '(', '');
  strFone := AnsiReplaceStr(strFone, ')', '');
  strFone := AnsiReplaceStr(strFone, ' ', '');
  strFone := AnsiReplaceStr(strFone, '-', '');

  If (Length(strFone) < 10) Or AnsiStartsStr('00', strFone) Then
    Result := False
  Else
    For intChar := 1 To Length(strFone) Do
    Begin
      If (Not CharInSet(strFone[intChar], ['0'..'9'])) Then
      Begin
        Result := False;
        Break;
      End;
    End;

end;

function fValidaCelular(strNumero: string): Boolean;
var
  strRegExp: string;
begin
  Result := False;

  strRegExp := '^[1-9]{2}(?:[6-9]|9[1-9])[0-9]{3}[0-9]{4}$';
  if TRegEx.IsMatch(strNumero, strRegExp) then
    Result := True;
end;


procedure pGravaCfgCertificadoDigital(strCerDig: String);
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsString := strCerDig;
      ParamByName('CODCFG').AsString := 'CFG_CERDIG';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

End;

{$IFNDEF LINUX}
procedure pAjustaLarguraDasColunas(DBGrid: TDBGrid);
var
  LTotalColunaLargura, LTotalColunas, LGridClientLargura, LLargura, i: Integer;
begin
  LTotalColunas := DBGrid.Columns.Count;
  if LTotalColunas = 0 then
    Exit;

  LTotalColunaLargura := 0;
  for i := 0 to LTotalColunas-1 do
    LTotalColunaLargura := LTotalColunaLargura + DBGrid.Columns[i].Width;
  if dgColLines in DBGrid.Options then
    LTotalColunaLargura := LTotalColunaLargura + LTotalColunas;

  LGridClientLargura := DBGrid.Width - GetSystemMetrics(SM_CXVSCROLL);
  if dgIndicator in DBGrid.Options then begin
    LGridClientLargura := LGridClientLargura - IndicatorWidth;
    if dgColLines in DBGrid.Options then
      Dec(LGridClientLargura);
  end;
  if DBGrid.BorderStyle = bsSingle then begin
    if DBGrid.Ctl3D then
      LGridClientLargura := LGridClientLargura - 4
    else
      LGridClientLargura := LGridClientLargura - 2;
  end;

  if LTotalColunaLargura < LGridClientLargura then begin
    LLargura := (LGridClientLargura - LTotalColunaLargura) div LTotalColunas;
    for i := 0 to LTotalColunas-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width + LLargura;
  end
  else if LTotalColunaLargura > LGridClientLargura then begin
    LLargura := (LTotalColunaLargura - LGridClientLargura) div LTotalColunas;
    if (LTotalColunaLargura - LGridClientLargura) mod LTotalColunas <> 0 then
      Inc(LLargura);
    for i := 0 to LTotalColunas-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width - LLargura;
  end;

end;
{$ENDIF}

function fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis(const strCodEmp : String = '') : Boolean;
var
  strEmpresa : String;
begin

  Result := False;

  strEmpresa := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

  If Not (fCfgSis('LOTCRP', varBoolean, strEmpresa)) Then
    Exit;

  If (fCfgSis('WMSLOT', varBoolean, strEmpresa)) Then
    Exit;

  If Not (fCfgSis('UTIWMS', varBoolean, strEmpresa)) Then
    Exit;

  Result := True;

end;

function fGravaLogLocFisica(strCodIte, strInfAnt, strInfNov: String; intTipAlt: Integer; strNumLote: String; strCodOpe: String = ''): Boolean;
Var
  strSQL   : String;
  qryGenLoc: TUniQuery;
Begin
  Try

    qryGenLoc := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' LOGLOC (AUTOINCREM,  ';
    strSQL := strSQL + '         LOC_CODEMP,  ';
    strSQL := strSQL + '         LOC_DTAALT,  ';
    strSQL := strSQL + '         LOC_HRAALT,  ';
    strSQL := strSQL + '         LOC_OPEALT,  ';
    strSQL := strSQL + '         LOC_CODITE,  ';
    strSQL := strSQL + '         LOC_INFANT,  ';
    strSQL := strSQL + '         LOC_TIPALT,  ';
    strSQL := strSQL + '         LOC_INFNOV,  ';
    strSQL := strSQL + '         LOC_NUMLOT)  ';
    strSQL := strSQL + ' VALUES (:AUTOIN,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :DTAALT,     ';
    strSQL := strSQL + '         :HRAALT,     ';
    strSQL := strSQL + '         :OPEALT,     ';
    strSQL := strSQL + '         :CODITE,     ';
    strSQL := strSQL + '         :INFANT,     ';
    strSQL := strSQL + '         :TIPALT,     ';
    strSQL := strSQL + '         :INFNOV,     ';
    strSQL := strSQL + '         :NUMLOT)     ';


    With qryGenLoc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString  := fRetAutoIncrem('LOGLOC',VS_strCodEmp);
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('DTAALT').AsDate    := VS_Date;
      ParamByName('HRAALT').AsTime    := fTime();

      If strCodOpe = '' Then
        ParamByName('OPEALT').AsString  := strLoginUsuarioLogado
      Else
        ParamByName('OPEALT').AsString  := strCodOpe;

      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('INFANT').AsString  := strInfAnt;
      ParamByName('INFNOV').AsString  := strInfNov;
      ParamByName('TIPALT').AsInteger := intTipAlt;
      ParamByName('NUMLOT').AsString  := strNumLote;


      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGravaLogLocFisica]');
    End;
  End;

  FreeAndNil(qryGenLoc);

End;

function fGravaLogContEst(strCodOpe, strCodIte, strNumLot: String; fltSalCon, fltSalMl: Double; strAutInc: String = ''): Boolean;
Var
  strSQL   : String;
  qryConEst: TUniQuery;
Begin
  Try
    qryConEst := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' LOGEST (AUTOINCREM,  ';
    strSQL := strSQL + '         EST_CODEMP,  ';
    strSQL := strSQL + '         EST_DTAALT,  ';
    strSQL := strSQL + '         EST_HRAALT,  ';
    strSQL := strSQL + '         EST_OPEALT,  ';
    strSQL := strSQL + '         EST_CODITE,  ';
    strSQL := strSQL + '         EST_NUMLOT,  ';
    strSQL := strSQL + '         EST_QTDCON,  ';
    strSQL := strSQL + '         EST_QTD_ML)  ';
    strSQL := strSQL + ' VALUES (:AUTOIN,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :DTAALT,     ';
    strSQL := strSQL + '         :HRAALT,     ';
    strSQL := strSQL + '         :OPEALT,     ';
    strSQL := strSQL + '         :CODITE,     ';
    strSQL := strSQL + '         :NUMLOT,     ';
    strSQL := strSQL + '         :QTDCON,     ';
    strSQL := strSQL + '         :QTD_ML)     ';

    With qryConEst Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If fEmptyStr(strAutInc) Then
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGEST', VS_strCodEmp)
      Else
        ParamByName('AUTOIN').AsString := strAutInc;

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('OPEALT').AsString := strCodOpe;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('QTDCON').AsFloat  := fltSalCon;
      ParamByName('QTD_ML').AsFloat  := fltSalMl;

      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGravaLogContEst]');
    End;
  End;
  FreeAndNil(qryConEst);
end;

function fConferenciaDepoisDaEntrada : Boolean;
Begin
  Result := (fCfgSis('TIPPNT', varString) = 'D');
End;

function fRetEmpresasWms(blnUtiWms: Boolean): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Result := '';

  Try

    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  GROUP_CONCAT(EMP_CODEMP) AS EMPRESA ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE    ';

    If (blnUtiWms) Then
      strSQL := strSQL + '  EMP_UTIWMS = "S"  '
    Else
      strSQL := strSQL + '  EMP_UTIWMS <> "S"  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('EMPRESA').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fRetSaldosEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''; blnIgnorarLote: Boolean = False): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  If fEmptyStr(strNumLot) Then
  Begin
    qryAux.SQL.Add('SELECT ITE_SALDOS FROM ITEGER WHERE ');
    qryAux.SQL.Add('ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ');


    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;
    Result := qryAux.FieldByName('ITE_SALDOS').AsFloat;
  End
  Else
  Begin
    With qryAux, SQL Do
    Begin
      Clear;
      Add(' SELECT SUM(LOT_SALDOS) AS LOT_SALDOS ');
      Add('   FROM CADLOT ');
      Add('  WHERE LOT_CODITE = :CODITE ');
      Add('    AND LOT_CODEMP = :CODEMP ');

      If (Not blnIgnorarLote) Then
        Add('    AND LOT_NUMLOT = :NUMLOT ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;

      If (Not blnIgnorarLote) Then
        ParamByName('NUMLOT').AsString := strNumLot;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('LOT_SALDOS').AsFloat
      Else
        Result := 0;

    End;
  End;

  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fRetSaldosMLEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  If fEmptyStr(strNumLot) Then
  Begin
    qryAux.SQL.Add('SELECT ITE_SAL_ML FROM ITEGER WHERE ');
    qryAux.SQL.Add('ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;
    Result := qryAux.FieldByName('ITE_SAL_ML').AsFloat;
  End Else
  Begin
    With qryAux, SQL Do
    Begin
      Clear;
      Add('SELECT LOT_SAL_ML');
      Add('FROM CADLOT');
      Add('WHERE');
      Add('  LOT_CODITE = :CODITE AND LOT_CODEMP = :CODEMP AND LOT_NUMLOT = :NUMLOT');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMLOT').AsString := strNumLot;

      Open;
      If Not IsEmpty Then
        Result := FieldByName('LOT_SAL_ML').AsFloat
      Else
        Result := 0;

    End;
  End;

  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fItemLoteChapa(strCodIte, strOpcDoc : String) : Boolean;
Begin
  If fCfgSis('MARMOR',varBoolean) And (Pos(strOpcDoc, 'PD_OR_VN_BR_') > 0)  Then
    Result := fItemMarmore(strCodIte)
  Else
    Result := False;
End;

Function fItemMarmore(strCodIte: String): Boolean;
Begin
  Result := false;
  If fCfgSis('MARMOR', varBoolean) Then
    Result := fCampoTabela('ITE_GRAMAR', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';
End;

function GetSQLReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True): String;
begin
  Result := '';
  Result := Result + ' UPDATE ITEGER SET  ';
  Result := Result + ' ITE_REPAUD = "S"   ';

  If AEntFut Then
    Result := Result +  '  ,ITE_REPAEF = "S" ';

  Result := Result +  ' WHERE ITE_CODITE = "' + ACodIte + '" ';

  If Not fEmptyStr(ACodEmp) Then
    Result := Result +  ' AND ITE_CODEMP = "' + ACodEmp + '" ';
end;

procedure ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True);
begin
  fExecutaSQL(GetSQLReprocessarItem(ACodIte, ACodEmp, AEntFut));
end;

Function fArrCodigosToText(arrCodigos: TConsultasArray): String;
  Var
    intContador: Integer;
    sltLista: TStringList;
Begin
  sltLista := TStringList.Create;

  For intContador := Low(arrCodigos) To High(arrCodigos) Do
    With arrCodigos[intContador] Do
      sltLista.Add(strCodigo);

  Result := sltLista.Text;

  FreeAndNil(sltLista);
End;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result := (fCfgSis('UTIWMS', VarString, strCodEmp) = 'S') And //Utilizar WMS ( Sistema de Gerênciamento de Armazém ) = SIM.
            (fCfgSis('CTLEST', VarString, strCodEmp) = '1') And //Tipo de controle de sub-estoque na mesma loja = POR LOTE.
            (fCfgSis('CADLOC', VarString, strCodEmp) = 'S') And //Utilizar cadastro de localizações físicas? = SIM.
            (fCfgSis('CONFME', VarString, strCodEmp) = '1') And //Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA.
            (fCfgSis('USACON', VarString, strCodEmp) = 'S') And //Utilizar Conferência para Entrada de Mercadorias? = SIM.
           ((fCfgSis('TIPEXP', varString, strCodEmp) = '3') Or  //Expedição = FATURAMENTO DEPOIS DA EXPEDICAO OU
            (fCfgSis('TIPEXP', varString, strCodEmp) = '4') Or  //            PEDIDO NÃO SERÁ FATURADO
            (fCfgSis('TIPEXP', varString, strCodEmp) = '5'));   //            PRÉ-ROMANEIO

end;

function fUsaSat(strCodEmp : String) : Boolean;
  Var
    strPathSat : String;
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If fCfgSis('USASAT', varBoolean, strCodEmp) and fCfgSis('SATECF', varBoolean, strCodEmp) Then
  Begin
    {$IFNDEF LINUX}
    strPathSat := IncludeTrailingPathDelimiter(fCfgSis('PATSAT', varString)) + 'opcoes_sat.ini';
    If FileExists(strPathSat) Then
      Result := StrToBool(fArqIniLocal(0, 'SATCFE', 'USASAT', '0', strPathSat ))
    Else
    {$ENDIF}
      Result := False;
  End
  Else
    Result := fCfgSis('USASAT', varBoolean, strCodEmp);
End;

{$IFDEF LINUX}
function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False;
                                 blnFaturamento: Boolean = True; strNumLot : String = '';
                                 blnConsiderarPedidos : Boolean = True;
                                 strCodEmp: String = ''; strNumPedAlt: String = '';
                                 blnConsiderarPedidoCompraPendente: Boolean = False;
                                 blnConsiderarCfgCalSal: Boolean = True;
                                 blnConsiderarOrdemProducao: Boolean = True;
                                 blnInformaSaldoGeralDisponivel: Boolean = False): Double;
  Var
    fltSalMl,
    fltCnvMl,
    fltSaldos,
    fltSalRes,
    fltSalResG,
    fltSalResE,
    fltSalResOP,
    fltSalEntFut,
    fltSalBaiFutRes,
    fltSalPendComp,
    fltSalExt: Double;
begin
  fltSalEntFut := 0;
  fltSalBaiFutRes := 0;
  fltSalPendComp := 0;
  fltSalResOP := 0;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If not blnCnvMl then
    fltCnvMl := 1
  Else
    fltCnvMl := fCampoTabela('ITE_CNV_ML','CADITE',['ITE_CODITE'],[strCodIte], False);

  If fltCnvMl = 0 Then
    fltCnvMl := 1;

  fltSalMl := fCampoTabela('ITE_SAL_ML','ITEGER',['ITE_CODITE', 'ITE_CODEMP'],[strCodIte, strCodEmp]);

  if blnInformaSaldoGeralDisponivel then
    fltSaldos := fRetSaldosEmpresa(strCodIte, strCodEmp, '')
  else
    fltSaldos := fRetSaldosEmpresa(strCodIte, strCodEmp, strNumLot);

  If blnConsiderarPedidos Then
  Begin
    fltSalRes := TSaldoReservado.New(
                   TReservaParametros.New()
                     .CodigoItem(strCodIte)
                     .CodEmpresa(strCodEmp)
                     .EmpresaItem(strCodEmp)
                     .NumeroDocumento(strNumPedAlt)
                     .NumeroLote(strNumLot)
                     .ConverterML(blnCnvMl)
                     .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                     .DesconsideraPedidosEnderecamento(True)
                     .TipoReserva(trsPedidoVenda)
                   ).fGetQuantidade();

    fltSalResE := TSaldoReservado.New(
                    TReservaParametros.New()
                      .CodigoItem(strCodIte)
                      .CodEmpresa(strCodEmp)
                      .EmpresaItem(strCodEmp)
                      .NumeroDocumento(strNumPedAlt)
                      .NumeroLote(strNumLot)
                      .ConverterML(blnCnvMl)
                      .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                      .TipoReserva(trsEnderecamento)
                    ).fGetQuantidade()
  End
  Else
  Begin
    fltSalRes := 0.00;
    fltSalResE := 0.00;
  End;

  fltSalResG := TSaldoReservado.New(
                  TReservaParametros.New()
                    .CodigoItem(strCodIte)
                    .CodEmpresa(strCodEmp)
                    .EmpresaItem(strCodEmp)
                    .NumeroDocumento(strNumPedAlt)
                    .NumeroLote(strNumLot)
                    .ConverterML(blnCnvMl)
                    .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                    .TipoReserva(trsGarantia)
                  ).fGetQuantidade();

  if blnConsiderarOrdemProducao then
  begin
    fltSalResOP := TSaldoReservado.New(
                     TReservaParametros.New()
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strCodEmp)
                       .EmpresaItem(strCodEmp)
                       .NumeroDocumento(strNumPedAlt)
                       .NumeroLote(strNumLot)
                       .ConverterML(blnCnvMl)
                       .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                       .TipoReserva(trsOrdemProducao)
                     ).fGetQuantidade();
  end;

  If fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal) Then
  Begin
    fltSalEntFut := TEntregaFutura.New(
                    TParamEF.New()
                      .CodIte(strCodIte)
                      .CodEmp(strCodEmp)
                      .Lote(strNumLot)
                      .ConverteML(blnCnvMl)
                      .Faturamento(blnFaturamento)
                      .TipoTE(IIF(blnFaturamento, tteAutomatica, tteTodas))
                    ).Total();

    fltSalBaiFutRes := TSaldoReservado.New(
                          TReservaParametros.New()
                          .CodigoItem(strCodIte)
                          .CodEmpresa(strCodEmp)
                          .EmpresaItem(strCodEmp)
                          .NumeroDocumento(strNumPedAlt)
                          .NumeroLote(strNumLot)
                          .ConverterML(blnCnvMl)
                          .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                          .TipoReserva(trsPedidoBaixaEntregaFuturaReservSaldo)
                       ).fGetQuantidade();
  End;

  If blnConsiderarPedidoCompraPendente Then
    fltSalPendComp := fRetQuantPendentePedidoCompra(strCodIte, '', QuotedStr(strCodEmp), True);

  fltSalExt := TSaldoReservado.New(
                 TReservaParametros.New()
                    .CodigoItem(strCodIte)
                    .CodEmpresa(strCodEmp)
                    .EmpresaItem(strCodEmp)
                    .NumeroDocumento(strNumPedAlt)
                    .NumeroLote(strNumLot)
                    .ConverterML(blnCnvMl)
                    .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                    .TipoReserva(trsExterno)
                 ).fGetQuantidade();

  If (fCfgSis('MOVFUL', varString) = '2') Then
    fltSalExt := 0;

  Result := (RoundTo((fltSaldos + fltSalEntFut + fltSalPendComp),-3) * fltCnvMl) - fltSalRes - fltSalResG - fltSalResE - fltSalResOP + fltSalMl - fltSalExt - fltSalBaiFutRes;

end;
{$ENDIF}

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Result := 0;
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                               ' +
        '   ITE_CODITE                         ' +
        '   , ITE_CNV_ML                       ' +
        '   , (:QTD / ITE_CNV_ML) AS RESULT    ' +
        ' FROM                                 ' +
        '   CADITE I                           ' +
        '   INNER JOIN DUP_CADBAS B            ' +
        '     ON I.ITE_CODITE = B.BAS_CODITE   ' +
        ' WHERE B.BAS_CODITE = :CODITE         ' +
        ' LIMIT 1                              ';
      qryGen.ParamByName('QTD').AsFloat := fltQuantidade;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      if qryGen.IsEmpty then
        Result := fltQuantidade
      else
        Result := qryGen.FieldByName('RESULT').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal: Boolean = True; strEmpSalRes : String = ''): Boolean;
begin
  {*********************************************************************}
  {* AO MUDAR AS CONDIÇÕES QUE DEIXA ESSA FUNÇÃO TRUE ADEQUAR A FUNÇÃO *}
  {* fRetSQLBaseadoNaCfgEmpOri EM untFatMostraEstoqueEmp               *}
  {******************************************************************VA*}
  Result := fCfgSis('ENTFUT', varBoolean, strEmpSalRes) And (Not fCfgSis('BEFTRG', VarBoolean));
  If blnConsiderarCfgCalSal Then
    Result := Result And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']);
end;

{*****************************************************************}
{* CARREGA TODOS OS FORNECEDORES FILIAIS DO CADASTRO DE EMPRESAS *}
{**************************************************************LU*}
{$IFDEF LINUX}
function fRetForFilialTodos(blnLista: Boolean = False): String;
Var
  qryGenerica :  TUniQuery;
  strSQL      : String;
begin
  qryGenerica := fCriaQuery;

  Result := '';

  strSQL := TFunctionFuncoesFaturamento.GetSelectFornecedorFilial;

  With qryGenerica Do
  Begin
    CLose;
    SQL.Clear;
    SQL.Add(strSQL);

    Result :=
      TFunctionFuncoesFaturamento.
        RetornarListaDeFornecedorFilial(ExecutarQueryEmCache(qryGenerica).Fields(0).AsString, blnLista);
  End;

  FreeAndNil(qryGenerica);
End;
{$ENDIF}

{$IFDEF LINUX}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
Begin
  If (Not fEmptyStr(strCodOpe)) Then
    strOperador := strCodOpe
  Else
    strOperador := strLoginUsuarioLogado;

  If (strNomeForm = 'frmLogoff') Or (strNomeForm = 'frmSobre') Then
    Exit(True);

  If fEhAdministrador(strOperador) Then
    Exit(True);

  Result := TPermissoesAcesso.GetInstance.fVerificaAcesso(strNomeForm, strOperador);

  Result := Result Or fEmptyStr(strNomeForm);
End;
{$ENDIF}

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

{$IFDEF LINUX}
function fEhOuCompoeEstrutura(strCodIte: String; strCodEmp: String=''): TItemEstru;
  Var
    qryGerMat : TUniQuery;
    LSql: String;
    LItemPrincipal: String;
begin
  Result.blnEstrutura     := False;
  Result.blnPrincipal     := False;
  Result.strItemPrincipal := '';

  LSql := fGetSQLEstruturaPai(IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp));

  LSql := 'SELECT SQL_NO_CACHE ITE_CODITE FROM (' + LSql + ') AS T';

  qryGerMat := fCriaQuery(nil);
  Try
    qryGerMat.Close;
    qryGerMat.Sql.Clear;
    qryGerMat.Sql.Add(LSql);
    qryGerMat.ParamByName('CODITE').AsString := strCodIte;

    LItemPrincipal := ExecutarQueryEmCache(qryGerMat).FieldByName('ITE_CODITE').AsString;

    Result.blnEstrutura     := Not LItemPrincipal.IsEmpty;
    Result.blnPrincipal     := strCodIte.Equals(LItemPrincipal);
    Result.strItemPrincipal := LItemPrincipal;
  Finally
    FreeAndNil(qryGerMat);
  End;
End;
{$ENDIF}

{$IFDEF LINUX}
function fEhItemServico(strCodIte: String; blnEntradaMercadoria : Boolean = False): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.fEhItemServico(strCodIte);
  If blnEntradaMercadoria And (Not Result) Then
    Result := (fCampoTabela('ITE_TIPPRO', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_StrCodEmp])= TIPO_PRODUTO_SPED[9,0]);
end;
{$ENDIF}


function fGetSQLEstruturaPai(strCodEmp: String): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                               ';
  Result := Result + '      G.AUTOINCREM,                                ';
  Result := Result + '      C.ITE_CODITE,                                ';
  Result := Result + '        ITE_DESITE,                                ';
  Result := Result + '        ITE_CODFAB,                                ';
  Result := Result + '        ITE_CODSIM,                                ';
  Result := Result + '        ITE_PRECUS,                                ';
  Result := Result + '        ITE_ICMSAI,                                ';
  Result := Result + '        ITE_IMPFED,                                ';
  Result := Result + '        ITE_DESOPE,                                ';
  Result := Result + '        ITE_OUTVAL                                 ';
  Result := Result + ' FROM GERMAT G                                     ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = GMT_CODITE  ';
  Result := Result + ' INNER JOIN ITEGER E ON E.ITE_CODITE = GMT_CODITE  ';
  Result := Result + '                    AND E.ITE_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + ' WHERE (GMT_CODITE = :CODITE)                      ';
  Result := Result + '    OR (SELECT COUNT(0)                            ';
  Result := Result + '        FROM DETMAT                                ';
  Result := Result + '        WHERE DMT_ITESUB = :CODITE > 0             ';
  Result := Result + '          AND DMT_SEQGER = G.AUTOINCREM)           ';
  Result := Result + ' ORDER BY ITE_DESITE                               ';
end;

function fRetEmpCarregamentoItem(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_EMPCAR', 'CADITE', ['ITE_CODITE'], [strCodIte]);
end;

function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
Begin
  Result := '';

  if fEmptyStr(strCodMot) then
    exit;

  Result := fCampoTabela('MOT_DESMOT', 'MOTVPD', ['MOT_CODMOT'], [strCodMot], False);
End;

end.


