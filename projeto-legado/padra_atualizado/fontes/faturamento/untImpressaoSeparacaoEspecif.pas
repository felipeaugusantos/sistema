unit untImpressaoSeparacaoEspecif;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Aurelius.Bind.Dataset,
  DB, System.Generics.Defaults, Vcl.Forms, Vcl.StdCtrls, Vcl.Controls, Uni,
  Vcl.ExtCtrls, UniClientDataSet, EditFocus, Types, Vcl.Graphics, CRAccess,
  System.Variants, MemoFocus, Vcl.ComCtrls, untIZClient, untModuloFatImp,
  Math, untTypesSistema, untFuncoesSimples, untConstantes,
  untFuncoes, untFuncoesGenerica, untImpNaoFiscal, Winapi.WinSpool, untFuncMacro,
  frxClass;

Type
  TImpSepEspecif = class(TObject)
  Private
    FModuloFatImp: TfrmModuloFatImp;

    FCadEmp: TUniQuery;
    FCadCli: TUniQuery;
    FMovGer: TUniQuery;
    FFatGor: TUniQuery;
    FMovGag: TUniQuery;
    FRelatorio: TUniQuery;

    FBarSep: Boolean;
    FConfir: Boolean;
    FSepFut: Boolean;
    FValSep: Boolean;
    FDocSep: Boolean;
    FEnt_CD: Boolean;
    FImpTck: Boolean;
    FblnImprimeDescricaoSimplificada: Boolean;

    FDadSep: TUniClientDataSet;
    FPais: TPais;

    FTabela: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FDesImp: String;
    FMsg_CD: String;
    FTransp: String;
    FNumPed: String;
    FEmpFat: String;
    FNomImp: String;
    FEntRet: String;
    F40ColS: String;
    FCodCli: String;
    FTabItens: String;

    procedure pCarregaQueryes(strTabela: String);
    procedure pCarregaEmpresa(strCodEmp: String);
    function  fGetSQLItens: String;

    function FatGor(strCampo: String): TField;
    function MovGag(strCampo: String): TField;
    function CadSep(strCampo: String): TField;
    function MovGer(strCampo: String): TField;
    function CadCli(strCampo: String): TField;
    function CadEmp(strCampo: String): TField;
    function CadEmpPed(strCampo: String): TField;

    procedure pCriaModuloFatImp;
    procedure pCriaClientSeparacao;
    procedure pInicializaDadosSeparacao;
    procedure pImprimeSepFast;
    function  fRetornaFrete(strTipFre: String): String;
    function  fRetornaConPagModelo4(strConPag: String): String;
    function  fRetornaFinanceiroExp(strCodCnd: String): Double;
    function  fRetornaParcelasExp: String;
    procedure pImprimeSEPGenerico;
    procedure pIniciaDadosSepPDOR;
    procedure pIniciaDadosSepOutros;
    Procedure pCarregaDadosClienteSeparacao;
    Procedure pCarregaDadosClienteSepOutros;
    Procedure pCarregaDadosClienteSepPDOR;
    Procedure pCarregaDadosClienteSepGeral;
    procedure pImprimeSEPCabGenerico;
    Function  fRetQtdItensLinhaInformAdicional(qryRel: TDataSet): Integer;
    procedure pImprimeSEPRodGenerico(blnTotal: Boolean);
    procedure pCabEmpresa74Col(blnEmpPed: Boolean = False);
    procedure pImprimeSeparacao;

    function Cond_10CPI(blnLiga: Boolean): String;
    function Cpi_12(blnLiga: Boolean): String;
    function Expandido(blnLiga: Boolean): String;
    function TamPag(intMaxLin: Integer): String;
    function Um_Oitavo(blnLiga: Boolean): String;

    procedure pAjustaSep80;
    procedure pAjustaSep40;

    procedure Imp(strTexto: String; blnPula: Boolean = True; blnRetCaractEsp: Boolean = True);
    procedure Reseta;
    procedure Eject;
  Public
    strRisco:  String;
    strColRel: String;
    strTipImp: String;
    strNomTab: String;
    strSeLfCo: String;
    strNroVia: String;
    strEmpFor: String;
    strSQLMovGer: String;
    strModLaySep: String;

    intLinPag: Integer;
    intQtdFol: Integer;
    intQtdPag: Integer;
    intQtdAdc: Integer;
    intIteImp: Integer;
    intPagina: Integer;
    intLinImp: Integer;
    intQtdVia: Integer;
    intNroVia: Integer;
    intQtdFolOri: Integer;
    intTotIteImp: Integer;
    intQtdLinCabFormAvulso: Integer;

    fltTotQtd: Double;
    fltVolume: Double;
    fltTotPed: Double;
    fltUniOri: Double;
    fltUnitar: Double;
    fltIpiPed: Double;
    fltSubPed: Double;
    fltDesPed: Double;
    fltDebCli: Double;
    fltTotDescItem: Double;

    blnCabEmp: Boolean;
    blnMeiFol: Boolean;
    blnTemSer: Boolean;
    blnEntMat: Boolean;
    blnImpPre: Boolean;
    blnVolEmb: Boolean;
    blnEmbSep: Boolean;
    blnComPre: Boolean;
    blnValTot: Boolean;

    blnRequisicao: Boolean;
    blnExpedicao: Boolean;
    blnFilaEmpDoc: Boolean;
    blnDocCancelado: Boolean;
    blnReimpressao: Boolean;
    blnImprimeLocalizacaoFisicaPedido: Boolean;

    impNaoFiscal: TImpNaoFiscal;

    qryCadEmpPed: TUniQuery;

    stlClaIpi: TStringList;

    Constructor Create(strNomImp: String; blnConfir: Boolean);
    Destructor Destroy; override;

    procedure pImprime(blnTemSer: Boolean;
                       strTabela,
                       strNumDoc,
                       strEspDoc,
                       strCodEmp,
                       strCodCli,
                       strNumPed,
                       strTransp: String;
                       fltDebCli: Double;
                       blnReimpressao: Boolean;
                       blnDocSep: Boolean = False;
                       blnComPre: Boolean = False;
                       blnImpTck: Boolean = False;
                       str40ColS: String  = '';
                       strTip_Fc: String  = '';
                       strOriDoc: String  = '';
                       strSQLItens: String  = '';
                       blnValTot: Boolean = False;
                       blnDocCan: Boolean = False;
                       strDesImp: String  = 'I';
                       intCopias: Integer = 1;
                       blnImpPed: Boolean = False;
                       blnEnt_CD: Boolean = False;
                       blnSepFut: Boolean = False;
                       strEntRet: String = '');

    property qryCadEmp: TUniQuery Read FCadEmp Write FCadEmp;
    property qryCadCli: TUniQuery Read FCadCli Write FCadCli;
    property qryMovGer: TUniQuery Read FMovGer Write FMovGer;
    property qryFatGor: TUniQuery Read FFatGor Write FFatGor;
    property qryMovGag: TUniQuery Read FMovGag Write FMovGag;
    property qryRelatorio: TUniQuery Read FRelatorio Write FRelatorio;
    property strNumDoc: String Read FNumDoc Write FNumDoc;
    property strEspDoc: String Read FEspDoc Write FEspDoc;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strCodCli: String Read FCodCli Write FCodCli;
    property strTabela: String Read FTabela Write FTabela;
    property blnImprimeDescricaoSimplificada: Boolean Read  FblnImprimeDescricaoSimplificada
                                                      Write FblnImprimeDescricaoSimplificada;
  End;

implementation

{ TImpSepEspecif }

uses untDocPDOR;

function TImpSepEspecif.CadCli(strCampo: String): TField;
  Var
    strIniCam: String;
begin
  If Pos(strCampo, 'CIDENT_ENDENT_BAIENT_CEPENT_TELENT_CONENT_REFENT_CODTRA') > 0 Then
    strIniCam := 'ETC_'
  Else
    strIniCam := 'CLI_';

  If strCampo <> 'ENDERE' Then
    Result := qryCadCli.FieldByName(strIniCam + strCampo)
  Else
    Result := qryCadCli.FieldByName(strCampo);
end;

function TImpSepEspecif.CadEmp(strCampo: String): TField;
begin
  Result := qryCadEmp.FieldByName('EMP_' + strCampo);
end;

function TImpSepEspecif.CadEmpPed(strCampo: String): TField;
begin
  Result := qryCadEmpPed.FieldByName('EMP_' + strCampo);
end;

function TImpSepEspecif.CadSep(strCampo: String): TField;
begin
  Result := FDadSep.FieldByName(strCampo);
end;

function TImpSepEspecif.Cond_10CPI(blnLiga: Boolean): String;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Result := '';
    Exit;
  End;

  If blnLiga Then
     Result := #15
  Else
     Result := #18;
end;

function TImpSepEspecif.Cpi_12(blnLiga: Boolean): String;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Result := '';
    Exit;
  End;

  If blnLiga Then
     Result := #27 + #77
  Else
     Result := #27 + #80;
end;

Constructor TImpSepEspecif.Create(strNomImp: String; blnConfir: Boolean);
  Var
    strMarca: String;
begin
  inherited Create;

  blnFilaEmpDoc := False;

  FEmpFat := fCfgSis('EMPFAT', varBoolean);

  FPais := fSetaPais;

  Try
    Self.FNomImp := strNomImp;
    Self.FConfir := blnConfir;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  strSeLfCo := fCfgSis('SELFCP');

  blnExpedicao := False;

  qryCadEmpPed := fCriaQuery;

  qryCadEmp := fCriaQuery;
  qryCadCli := fCriaQuery;
  qryMovGer := fCriaQuery;
  qryFatGor := fCriaQuery;
  qryMovGag := fCriaQuery;
  qryRelatorio := fCriaQuery;

  fltVolume := 0;
  blnVolEmb := (fCfgSis('TIPVOL') = '1');

  strMarca := fArqIniLocal(0, 'GERAL', 'MARCA', '', 'opcoes_nao_fiscal.ini');
  If (fArqIniLocal(0, 'GERAL', 'USAIMP', '', 'opcoes_nao_fiscal.ini') = 'S') Then
    impNaoFiscal := TImpNaoFiscal.fCriaImpressora(strMarca);

  stlClaIpi := TStringList.Create;
  stlClaIpi.Sorted := True;
  stlClaIpi.Duplicates := dupIgnore;

  intQtdLinCabFormAvulso := fCfgSis('LINCAV', varInteger);
  blnImprimeLocalizacaoFisicaPedido := fCfgSis('PVELOC', varBoolean);
end;

destructor TImpSepEspecif.Destroy;
begin
  qryCadEmpPed.Close;
  qryCadEmp.Close;
  qryCadCli.Close;
  qryMovGer.Close;
  qryFatGor.Close;
  qryMovGag.Close;
  FreeAndNil(qryCadEmpPed);
  FreeAndNil(FCadEmp);
  FreeAndNil(FCadCli);
  FreeAndNil(FMovGer);
  FreeAndNil(FFatGor);
  FreeAndNil(FMovGag);

  FreeAndNil(impNaoFiscal);
  FreeAndNil(stlClaIpi);

  inherited Destroy;
end;

procedure TImpSepEspecif.Eject;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Exit;
  End;

  Imp(#12);
  Reseta;
end;

function TImpSepEspecif.Expandido(blnLiga: Boolean): String;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Result := '';
    Exit;
  End;

  If blnLiga Then
     Result := #27 + #87 + '1'
  Else
     Result := #27 + #87 + '0';
end;

function TImpSepEspecif.FatGor(strCampo: String): TField;
begin
  Result := qryFatGor.FieldByName('FGO_' + strCampo);
end;

function TImpSepEspecif.fGetSQLItens: String;
begin
  Result := TLeDocumentoPDOR.Create(nil).fSQLItems();
end;

function TImpSepEspecif.fRetornaConPagModelo4(strConPag: String): String;
begin
  Result := '';

  If strConPag = '01000' Then
    Result := 'A VISTA'
  Else
  Begin
    strConPag := RightStr(strConPag, Length(strConPag) -2);
    While (Length(strConPag) > 0) Do
    Begin
      Result := Result + IntToStr(StrToInt(LeftStr(strConPag, 3))) + '/';
      strConPag := RightStr(strConPag, Length(strConPag) -3);
    End;

    Result := LeftStr(Result, Length(Result) -1);
  End;
end;

function TImpSepEspecif.fRetornaFinanceiroExp(strCodCnd: String): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT CND_PEDEAC FROM CADCND WHERE CND_CODIGO = :CODCND');
  qryAux.ParamByName('CODCND').AsString := strCodCnd;
  qryAux.Open;

  Result := qryAux.FieldByName('CND_PEDEAC').AsFloat;

  FreeAndNil(qryAux);
end;

function TImpSepEspecif.fRetornaFrete(strTipFre: String): String;
begin
  Result := '';

  If fEmptyStr(strTipFre) Then
    Exit;

  Case strTipFre[1] Of
    '1': Result := 'Emitente';
    '2': Result := 'Destinatário';
    '3': Result := 'Terceiros';
    '9': Result := 'Sem Frete';
  End;
end;

function TImpSepEspecif.fRetornaParcelasExp: String;
  Var
    intContador: Integer;
    intQtdParc: Integer;
    intDiasVenc: Integer;

  function fDiasVenc(strConPag: String; intParc: Integer): Integer;
  begin
    Result := StrToIntDef(Copy(strConPag, 3 + (intParc-1) * 3, 3), -1);
  end;
begin
  intQtdParc := StrToIntDef(LeftStr(FatGor('CONPAG').AsString, 2), 0);

  Result := '';
  For intContador := 1 To Max(intQtdParc, 6) Do
  Begin
    intDiasVenc := fDiasVenc(FatGor('CONPAG').AsString, intContador);

    If intDiasVenc < 0 Then
    Begin
      Break;
    End;

    Result := Result + Chr(intContador+64) + ') ' +
                       FormatDateTime('dd/mm/yyyy', FatGor('DTAENT').AsDateTime+intDiasVenc) + ' ' +
                       fPadL(FloatToStrF(FatGor('VPAR' + fStrZero(intContador,2)).AsFloat, ffNumber, 12, 2), 11) + '  ';

    If intContador = 3 Then
    Begin
      Result := Result + #13#10;
    End;
  End;
end;

function TImpSepEspecif.fRetQtdItensLinhaInformAdicional(qryRel: TDataSet): Integer;

  function fImpLocfisica: Boolean; begin
    Result :=(FEspDoc = 'PD') And blnImprimeLocalizacaoFisicaPedido And
             (Not fEmptyStr(qryRel.FieldByName('LOCFIS').AsString));
  end;

Begin
  Result := 0;

  Try
    qryRel.DisableControls();

    With qryRel Do Begin
      First;

      While Not eof do Begin
        If (Not fEmptyStr(FieldByName('NUMLOT').AsString)) Or fImpLocfisica Then
          Inc(Result);

        Next;
      End;
    End;
  Finally
    qryRel.EnableControls();
  End;
End;

procedure TImpSepEspecif.Imp(strTexto: String; blnPula, blnRetCaractEsp: Boolean);
  Var
    escritos: Cardinal;
begin
  If (blnRetCaractEsp) Then
    strTexto := fTiraCaracEspeciais(strTexto, False);

  If Not Assigned(impNaoFiscal) Then
  Begin
    WritePrinter(PrinterHandler, Pointer(strTexto), Length(strTexto), escritos);
    If (blnPula) Then
    Begin
      strTexto := #13#10;
      WritePrinter(PrinterHandler, Pointer(strTexto), 2, escritos);
    End;
  End
  Else
  Begin
    If (Not fEmptyStr(strTexto)) Or (blnPula) Then
      impNaoFiscal.pEscreveNormal(strTexto);
  End;
end;

function TImpSepEspecif.MovGag(strCampo: String): TField;
begin
  Result := qryMovGag.FieldByName('GAG_' + strCampo);
end;

function TImpSepEspecif.MovGer(strCampo: String): TField;
begin
  Result := qryMovGer.FieldByName('GER_' + strCampo);
end;

procedure TImpSepEspecif.pAjustaSep40;
begin
  With FModuloFatImp.frxDocSep40 Do
  Begin
    FindObject('ChildVendedor').Visible     := (FEspDoc <> 'BR');
    FindObject('ChildDigitador').Visible    := fCfgSis('USADIG', varBoolean);
    FindObject('ChildProfis').Visible       := (Pos(FEspDoc, 'PD_OR_') <= 0) And fCfgSis('IMPPRO', varBoolean);
    FindObject('ChildCodFab').Visible       := fCfgSis('SP40CF', varBoolean);
    FindObject('ChildRomaneio').Visible     := fCfgSis('MOSMRE', varBoolean) And (Pos(FEspDoc, 'PD_OR_') <= 0);
    FindObject('ChildDadosCliente').Visible := F40ColS <> 'S';
    {***************************************}
    {* IMPRIMIR VALORES NA SEPARAÇÃO (S/N) *}
    {************************************RV*}
    FindObject('rllTitValUni').Visible      := FValSep;
    FindObject('rllTitValTot').Visible      := FValSep;
    FindObject('rldValUni').Visible         := FValSep;
    FindObject('rldValTot').Visible         := FValSep;
    FindObject('ChildValSep').Visible       := FValSep;
    FindObject('Linha4').Visible            := FValSep;
    FindObject('Linha3').Visible            := (Not fVAlSep);

    If FBarSep Then
    Begin
      TfrxMemoView(FindObject('mmoTitCodFab')).Text := 'COD.BAR.';
      TfrxMemoView(FindObject('mmoCodFab')).Text    := '[frxItens."CODBAR"]';
    End;

    If blnRequisicao Then
      TfrxMemoView(FindObject('dbTITULO')).Text := 'REQUISICAO - [frxCadSep."NUMDOC"] - [frxCadSep."ESPDOC"] - [frxCadEmp."EMP_CODEMP"]';

    FindObject('ChildEmpFor').Visible          := (Not fEmptyStr(strEmpFor));
    TfrxMemoView(FindObject('rlbEmpFor')).Text := strEmpFor + '-' + fRetNomeEmpresaSelec(strEmpFor);

  End;
end;

procedure TImpSepEspecif.pAjustaSep80;
  Var
    blnSaiMar: Boolean;
Begin
  blnSaiMar := fCfgSis('SAIMAR', varBoolean);

  With FModuloFatImp.frxDocSep80 Do
  Begin
    If (strModLaySep = '1') Then
    Begin
      FindObject('HeaderModelo2').Visible           := False;
      FindObject('MasterDataModelo2').Visible       := False;

      FindObject('HeaderModelo2EmbSep').Visible     := False;
      FindObject('MasterDataModelo2EmbSep').Visible := False;

      FindObject('HeaderModelo3').Visible           := False;
      FindObject('MasterDataModelo3').Visible       := False;

      If Not fCfgSis('EMBSEP', varBoolean) Then
      Begin
        FindObject('mmoQtdEmbTit').Visible := False;
        FindObject('mmoQtdEmb').Visible    := False;
      End;
    End;

    If (strModLaySep = '2') Then
    Begin

      FindObject('Header1').Visible     := False;
      FindObject('MasterData1').Visible := False;

      FindObject('HeaderModelo3').Visible           := False;
      FindObject('MasterDataModelo3').Visible       := False;

      If fCfgSis('EMBSEP', varBoolean) Then
      Begin
        FindObject('HeaderModelo2').Visible           := False;
        FindObject('MasterDataModelo2').Visible       := False;
      End Else
      Begin
        FindObject('HeaderModelo2EmbSep').Visible     := False;
        FindObject('MasterDataModelo2EmbSep').Visible := False;
      End;
    End;

    If (strModLaySep = '3') Then
    Begin

      FindObject('Header1').Visible     := False;
      FindObject('MasterData1').Visible := False;

      FindObject('HeaderModelo2EmbSep').Visible     := False;
      FindObject('MasterDataModelo2EmbSep').Visible := False;

      FindObject('HeaderModelo2').Visible           := False;
      FindObject('MasterDataModelo2').Visible       := False;

      TfrxMemoView(FindObject('Memo41')).Text := '[SUM(<frxItens."QTDITE">,MasterDataModelo3)]';
    End;

    FindObject('mmoTitVended').Visible    := (FEspDoc <> 'BR');
    FindObject('mmoVended').Visible       := FindObject('mmoTitVended').Visible;

    FindObject('mmoTitDigita').Visible    := fCfgSis('USADIG', varBoolean);
    FindObject('mmoDigita').Visible       := FindObject('mmoTitDigita').Visible;

    FindObject('mmoTitProfis').Visible    := (Pos(FEspDoc, 'PD_OR_') <= 0) And fCfgSis('IMPPRO', varBoolean);
    FindObject('mmoProfis').Visible       := FindObject('mmoTitProfis').Visible;

    FindObject('mmoTitDesMar').Visible    := blnSaiMar;
    FindObject('mmoDesMar').Visible       := FindObject('mmoTitDesMar').Visible;

    FindObject('mmoTitDesIte').Width      := FindObject('mmoTitDesIte').Width + IIF(blnSaiMar, 0, FindObject('mmoTitDesMar').Width);
    FindObject('mmoDesIte').Width         := FindObject('mmoTitDesIte').Width;

    FindObject('pghCabecEmpresa').Visible := Pos(FEspDoc, VS_strNaoCab) <= 0;
    FindObject('mmoNumPag2').Visible      := Not FindObject('pghCabecEmpresa').Visible;

    {***************************************}
    {* IMPRIMIR VALORES NA SEPARAÇÃO (S/N) *}
    {************************************RV*}
    FindObject('rllTitValUni').Visible    := FValSep;
    FindObject('rllTitValTot').Visible    := FValSep;
    FindObject('rldValUni').Visible       := FValSep;
    FindObject('rldValTot').Visible       := FValSep;

    If Not (FValSep) Then
    Begin
      FindObject('rldValUni').top      := 0;
      FindObject('rldValTot').top      := 0;

      If Not fCfgSis('EMBSEP', varBoolean) Then
      Begin
        FindObject('Shape1').Height         := FindObject('Shape1').Height - FindObject('rllTitValUni').Height;
        FindObject('Header1').Height        := FindObject('Shape1').Height;
        FindObject('MasterData1').Height    := FindObject('MasterData1').Height - FindObject('rllTitValUni').Height;
      End;
    End;

    If FBarSep Then
    Begin
      TfrxMemoView(FindObject('mmoTitCodFab')).Text := 'COD.BARRAS';
      TfrxMemoView(FindObject('mmoCodFab')).Text    := '[frxItens."CODBAR"]';
    End;

    If fCfgSis('SELFCP') = 'C' Then
    Begin
      TfrxMemoView(FindObject('mmoTitLocFis')).Text := 'COMPLEMENTO';
      TfrxMemoView(FindObject('mmoLocFis')).Text    := '[frxItens."COMPLE"]';
    End;

    If blnRequisicao Then
      TfrxMemoView(FindObject('dbTITULO')).Text := 'REQUISIÇÃO - [frxCadSep."NUMDOC"] - [frxCadSep."ESPDOC"] - [frxCadEmp."EMP_CODEMP"]';

    FindObject('rllEmpFor').Visible            := (Not fEmptyStr(strEmpFor));
    FindObject('rlbEmpFor').Visible            := (Not fEmptyStr(strEmpFor));
    TfrxMemoView(FindObject('rlbEmpFor')).Text := strEmpFor + '-' + fRetNomeEmpresaSelec(strEmpFor);

  End;
End;

procedure TImpSepEspecif.pCabEmpresa74Col(blnEmpPed: Boolean);
begin
  If (fCfgSis('RAZFAN') = 'R') Then
  Begin
    If (blnEmpPed) Then
      Imp(Expandido(True) + fPadR(CadEmpPed('NOMEMP').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6))
    Else
      Imp(Expandido(True) + fPadR(CadEmp('NOMEMP').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6));
  End
  Else
  Begin
    If Not fEmptyStr(CadEmp('NOMFAN').AsString) Then
    Begin
      If (blnEmpPed) Then
        Imp(Expandido(True) + fPadR(CadEmpPed('NOMFAN').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6))
      Else
        Imp(Expandido(True) + fPadR(CadEmp('NOMFAN').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6));
    End
    Else
    Begin
      If (blnEmpPed) Then
        Imp(Expandido(True) + fPadR(CadEmpPed('NOMEMP').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6))
      Else
        Imp(Expandido(True) + fPadR(CadEmp('NOMEMP').AsString, 74) + Expandido(False) + fPadR(strNroVia,   6));
    End;
  End;
end;

procedure TImpSepEspecif.pCarregaDadosClienteSeparacao;
begin
  If (Pos(FEspDoc, 'PD_OR') <= 0) And fClienteConsumidor(CadCli('NOMCLI').AsString,True, True) Then
    pCarregaDadosClienteSepOutros

  Else If (Pos(FEspDoc, 'PD_OR_') > 0) And fClienteConsumidor(CadCli('NOMCLI').AsString,True, True) Then
    pCarregaDadosClienteSepPDOR

  Else
    pCarregaDadosClienteSepGeral;
end;

procedure TImpSepEspecif.pCarregaDadosClienteSepGeral;
begin
  With FDadSep Do
  Begin
    FieldByName('CODCLI').AsString := CadCli('CODCLI').AsString;
    FieldByName('NOMCLI').AsString := CadCli('NOMCLI').AsString;
    FieldByName('NOMFAN').AsString := CadCli('FANSOB').AsString;
    FieldByName('ENDCLI').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('ENDERE').AsString, CadCli('ENDENT').AsString);
    FieldByName('BAICLI').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('BAIRRO').AsString, CadCli('BAIENT').AsString);
    FieldByName('CIDCLI').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('NOMCID').AsString + '-' + CadCli('ESTADO').AsString, CadCli('NCIDEN').AsString + '-' + CadCli('NESTEN').AsString);
    FieldByName('CGCCPF').AsString := fFormataCpfCgc(CadCli('C_G_C_').AsString, FPais, fRetNomCidade(IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('CODCID').AsString, CadCli('CIDENT').AsString),1));
    FieldByName('TELCLI').AsString := fFormataFone(IIF(fEmptyStr(CadCli('TELENT').AsString), CadCli('FONE01').AsString, CadCli('TELENT').AsString));
    FieldByName('REFERE').AsString := CadCli('REFENT').AsString;
    If (CadCli('CGCCPF').AsInteger = 1) Then
    Begin
      FieldByName('IES_RG').AsString := CadCli('I_E_S_').AsString;
    End
    Else
    Begin
      FieldByName('IES_RG').AsString := CadCli('NUMR_G').AsString;
    End;
    FieldByName('CEPCLI').AsString := fFormataCEP(IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('C_E_P_').AsString, CadCli('CEPENT').AsString));
    FieldByName('SUBREG').AsString := CadCli('CODSUB').AsString + IIF(Not fEmptyStr(CadCli('CODSUB').AsString), ' - ' + fRetNomSubRegiao(CadCli('CODSUB').AsString), '');
    FieldByName('REGIAO').AsString := CadCli('CODREG').AsString + IIF(Not fEmptyStr(CadCli('CODREG').AsString), ' - ' + fRetNomRegiao(CadCli('CODREG').AsString), '');
  End;
end;

procedure TImpSepEspecif.pCarregaDadosClienteSepOutros;
begin
  With FDadSep Do
  Begin
    FieldByName('CODCLI').AsString := MovGer('CODCLI').AsString;
    FieldByName('NOMCLI').AsString := MovGer('NOMCON').AsString;
    FieldByName('NOMFAN').AsString := CadCli('FANSOB').AsString;
    FieldByName('ENDCLI').AsString := MovGer('ENDCON').AsString;
    FieldByName('BAICLI').AsString := MovGer('BAICON').AsString;
    If (MovGer('CGCCPF').AsInteger = 1) Then
    Begin
      FieldByName('IES_RG').AsString := MovGer('IESCON').AsString;
    End
    Else
    Begin
      FieldByName('IES_RG').AsString := MovGer('R_GCON').AsString;
    End;
    FieldByName('CIDCLI').AsString := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    FieldByName('CGCCPF').AsString := fFormataCpfCgc(MovGer('CGCCON').AsString, FPais);
    FieldByName('TELCLI').AsString := MovGer('TELCON').AsString;
    FieldByName('CEPCLI').AsString := fFormataCEP(MovGer('CEPCON').AsString);
    FieldByName('REFERE').AsString := '';
    FieldByName('SUBREG').AsString := CadCli('CODSUB').AsString + IIF(Not fEmptyStr(CadCli('CODSUB').AsString), ' - ' + fRetNomSubRegiao(CadCli('CODSUB').AsString), '');
    FieldByName('REGIAO').AsString := CadCli('CODREG').AsString + IIF(Not fEmptyStr(CadCli('CODREG').AsString), ' - ' + fRetNomRegiao(CadCli('CODREG').AsString), '');
  End
end;

procedure TImpSepEspecif.pCarregaDadosClienteSepPDOR;
begin
  With FDadSep Do
  Begin
    FieldByName('CODCLI').AsString := FatGor('CODCLI').AsString;
    FieldByName('NOMCLI').AsString := FatGor('NOMCON').AsString;
    FieldByName('NOMFAN').AsString := CadCli('FANSOB').AsString;
    FieldByName('ENDCLI').AsString := FatGor('ENDCON').AsString;
    FieldByName('BAICLI').AsString := FatGor('BAICON').AsString;
    FieldByName('CGCCPF').AsString := fFormataCpfCgc(FatGor('CGCCON').AsString, FPais, fRetNomCidade(FatGor('CIDCON').AsString,1));
    If (FatGor('CGCCPF').AsInteger = 1) Then
    Begin
      FieldByName('IES_RG').AsString := FatGor('IESCON').AsString;
    End
    Else
    Begin
      FieldByName('IES_RG').AsString := FatGor('R_GCON').AsString;
    End;
    FieldByName('CIDCLI').AsString := fRetNomCidade(FatGor('CIDCON').AsString, 0) + '-' + fRetNomCidade(FatGor('CIDCON').AsString, 1);
    FieldByName('CGCCPF').AsString := fFormataCpfCgc(FatGor('CGCCON').AsString, FPais);
    FieldByName('TELCLI').AsString := FatGor('TELCON').AsString;
    FieldByName('CEPCLI').AsString := fFormataCEP(FatGor('CEPCON').AsString);
    FieldByName('REFERE').AsString := '';
    FieldByName('SUBREG').AsString := CadCli('CODSUB').AsString + IIF(Not fEmptyStr(CadCli('CODSUB').AsString), ' - ' + fRetNomSubRegiao(CadCli('CODSUB').AsString), '');
    FieldByName('REGIAO').AsString := CadCli('CODREG').AsString + IIF(Not fEmptyStr(CadCli('CODREG').AsString), ' - ' + fRetNomRegiao(CadCli('CODREG').AsString), '');
  End
end;

procedure TImpSepEspecif.pCarregaEmpresa(strCodEmp: String);
begin
  With qryCadEmp Do Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE           ');
    SQL.Add('  CADEMP.*,                   ');
    SQL.Add('  CID_NOMCID AS EMP_NOMCID,   ');
    SQL.Add('  CID_ESTADO AS EMP_ESTADO    ');
    SQL.Add('FROM                          ');
    SQL.Add('  CADEMP,                     ');
    SQL.Add('  CADCID                      ');
    SQL.Add('WHERE                         ');
    SQL.Add('  CID_CODCID = EMP_CODCID AND ');
    SQL.Add('  EMP_CODEMP = :CODEMP        ');
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
end;

procedure TImpSepEspecif.pCarregaQueryes(strTabela: String);
begin
  Try
    Try
      strSQLMovGer := '';

      pCarregaEmpresa(FCodEmp);

      If (strTabela = 'FATGOR') Then Begin

        With qryFatGor Do Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE        ');
          SQL.Add('  *                        ');
          SQL.Add('FROM                       ');
          SQL.Add('  FATGOR                   ');
          SQL.Add('  LEFT JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM ');
          SQL.Add('WHERE                      ');
          SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
          SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
          SQL.Add('  FGO_CODEMP = :CODEMP     ');

          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('ESPDOC').AsString := FEspDoc;
          ParamByName('CODEMP').AsString := FCodEmp;

          Open;
        End;

      End;

      If (strTabela = 'DEL_FATGOR') Then Begin

        With qryFatGor Do Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE        ');
          SQL.Add('  *                        ');
          SQL.Add('FROM                       ');
          SQL.Add('  DEL_FATGOR               ');
          SQL.Add('  LEFT JOIN DEL_EXTGOR ON FGO_SEQFGO = AUTOINCREM ');
          SQL.Add('WHERE                      ');
          SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
          SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
          SQL.Add('  FGO_CODEMP = :CODEMP     ');
          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('ESPDOC').AsString := FEspDoc;
          ParamByName('CODEMP').AsString := FCodEmp;
          Open;
        End;

      End

      Else If (strTabela = 'MOVGAG') Then Begin

        With qryMovGag Do Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE        ');
          SQL.Add('  *                        ');
          SQL.Add('FROM                       ');
          SQL.Add('  MOVGAG                   ');
          SQL.Add('WHERE                      ');
          SQL.Add('  GAG_NUMENT = :NUMDOC AND ');
          SQL.Add('  GAG_CODEMP = :CODEMP     ');
          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('CODEMP').AsString := FCodEmp;
          Open;
        End;

      End

      Else If (strTabela = 'ENTGER') Then Begin

        With qryMovGer Do Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE        ');
          SQL.Add('  *                        ');
          SQL.Add('FROM                       ');
          SQL.Add('  ' + strTabela + '        ');
          SQL.Add('WHERE                      ');
          SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
          SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
          SQL.Add('  GER_CODEMP = :CODEMP     ');

          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('ESPDOC').AsString := FEspDoc;
          ParamByName('CODEMP').AsString := FCodEmp;
          Open;
        End;

        strSQLMovGer := qryMovGer.SQL.GetText;
      End

      Else If (strTabela <> 'FATGOR') Then Begin

        With qryMovGer Do Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE        ');
          SQL.Add('  *                        ');

          If Pos('NOTGER', strTabela) > 0 Then
            SQL.Add('  ,"N" AS GER_ENTFUT ');

          SQL.Add('FROM                       ');
          SQL.Add('  ' + strTabela + '        ');
          SQL.Add('WHERE                      ');
          if (FEspDoc <> 'GF') Then
            SQL.Add('  GER_TIP_FC = "C"     AND ');

          If SameText(FEspDoc, 'ML') Then Begin
            SQL.Add('  GER_NUMFAT = :NUMDOC AND ');
            SQL.Add('  GER_TIPFAT = "AJ"    AND ');
          End Else
            SQL.Add('  GER_NUMDOC = :NUMDOC AND ');

          SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
          SQL.Add('  GER_CODEMP = :CODEMP     ');

          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('ESPDOC').AsString := FEspDoc;
          ParamByName('CODEMP').AsString := FCodEmp;
          Open;
        End;

        strSQLMovGer := qryMovGer.SQL.GetText;
      End;

      With qryCadCli Do Begin
        Close;
        SQL.Clear;
        SQL.Text := fRetSQLEnderecoEntregaCli(strTabela, True);

        If (strTabela = 'FATGOR') Then Begin
          ParamByName('CODCLI').AsString := FatGor('CODCLI').AsString;

          If Params.FindParam('SEQGER') <> Nil Then
            ParamByName('SEQGER').AsString := qryFatGor.FieldByName('AUTOINCREM').AsString;
        End

        Else If (strTabela = 'DEL_FATGOR') Then Begin
          ParamByName('CODCLI').AsString := FatGor('CODCLI').AsString;

          If Params.FindParam('SEQGER') <> Nil Then
            ParamByName('SEQGER').AsString := qryFatGor.FieldByName('AUTOINCREM').AsString;
        End

        Else If (strTabela = 'MOVGAG') Then Begin
          ParamByName('CODCLI').AsString := MovGag('CODCLI').AsString;

          If Params.FindParam('SEQGER') <> Nil Then
            ParamByName('SEQGER').AsString := qryMovGag.FieldByName('AUTOINCREM').AsString;
        End

        Else Begin
          ParamByName('CODCLI').AsString := MovGer('CODCLI').AsString;

          If Params.FindParam('SEQGER') <> Nil Then
            ParamByName('SEQGER').AsString := qryMovGer.FieldByName('AUTOINCREM').AsString;
        End;

        Open;
      End;

      With qryRelatorio Do Begin
        Close();
        SQL.Clear();
        SQL.Text := fGetSQLItens();
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open();
      End;
    Finally

    End;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpSepEspecif.pCarregaQueryes]');
  End;
end;

procedure TImpSepEspecif.pCriaClientSeparacao;
  Var
    intContador: Integer;

  Procedure pIncluiCampo(strCodCam: String; intTamCam: Integer; typCampo: TFieldType = ftString); Begin
    With FDadSep.FieldDefs.AddFieldDef Do Begin
      Name     := strCodCam;
      DataType := typCampo;

      If intTamCam <> 0 Then
        Size := intTamCam;
    End;
  End;

Begin
  Try
    FDadSep := TUniClientDataSet.Create(Application);

    pIncluiCampo('CODVEN', 003);
    pIncluiCampo('CODVE2', 003);
    pIncluiCampo('CODDIG', 003);
    pIncluiCampo('DTAENT', 010);
    pIncluiCampo('HORENT', 010);

    For intContador := 1 To 5 Do
      pIncluiCampo('MEN00' + IntToStr(intContador), 200);

    pIncluiCampo('PROFIS', 100);

    pIncluiCampo('CODCLI', 008);
    pIncluiCampo('NOMCLI', 200);
    pIncluiCampo('NOMFAN', 200);
    pIncluiCampo('ENDCLI', 200);
    pIncluiCampo('BAICLI', 200);
    pIncluiCampo('CGCCPF', 100);
    pIncluiCampo('IES_RG', 100);
    pIncluiCampo('CIDCLI', 200);
    pIncluiCampo('TELCLI', 050);
    pIncluiCampo('CEPCLI', 050);
    pIncluiCampo('REFERE', 100);
    pIncluiCampo('MENEXP', 200);
    pIncluiCampo('MENEX2', 200);
    pIncluiCampo('MENEX3', 200);
    pIncluiCampo('MENEX4', 200);
    pIncluiCampo('ENTFAT', 001);
    pIncluiCampo('DTENTR', 010);
    pIncluiCampo('PESBRU', 020);
    pIncluiCampo('PESLIQ', 020);
    pIncluiCampo('SEPFUT', 001);
    pIncluiCampo('ENTURG', 001);
    pIncluiCampo('NUMDOC', 012);
    pIncluiCampo('ESPDOC', 002);
    pIncluiCampo('ENT_CD', 003);
    pIncluiCampo('REIMPR', 020);
    pIncluiCampo('SPESOS', 100);
    pIncluiCampo('SPES40', 100);
    pIncluiCampo('TRANSP', 100);
    pIncluiCampo('ENDENT', 200);
    pIncluiCampo('ENDTRA', 100);
    pIncluiCampo('BAITRA', 100);
    pIncluiCampo('CIDTRA', 100);
    pIncluiCampo('ROMANE', 200);
    pIncluiCampo('ROMA40', 200);
    pIncluiCampo('VENDED', 200);
    pIncluiCampo('VENDE2', 200);
    pIncluiCampo('DIGITA', 200);
    pIncluiCampo('MENSAG', 0, ftMemo);
    pIncluiCampo('MENSA2', 0, ftMemo);
    pIncluiCampo('SALTO',  0, ftMemo);
    pIncluiCampo('CONPAG', 060);
    pIncluiCampo('PARCEL', 200);
    pIncluiCampo('FINANC', 0, ftFloat);
    pIncluiCampo('CNDMD4', 200);
    pIncluiCampo('FRETE_', 020);
    pIncluiCampo('PORDES', 0, ftFloat);
    pIncluiCampo('VLRCON', 0, ftFloat);
    pIncluiCampo('DESESP', 0, ftFloat);
    pIncluiCampo('TOTPRO', 0, ftFloat);
    pIncluiCampo('TOTFRE', 0, ftFloat);
    pIncluiCampo('TOTIPI', 0, ftFloat);
    pIncluiCampo('SUBREG', 50);
    pIncluiCampo('REGIAO', 50);

    FDadSep.CreateDataSet;
    FDadSep.Open;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpSepEspecif.pCriaClientSeparacao]');
  End;
end;

procedure TImpSepEspecif.pCriaModuloFatImp;
begin
  pCriarFormularios(TfrmModuloFatImp,FModuloFatImp);
end;

procedure TImpSepEspecif.pImprimeSEPCabGenerico;
  Var
    strControle,
    strEntRet,
    strCodCli: String;
    intCont: Integer;
    intEspacoCab: Integer;

    strCabLocFis: String;
begin
  strControle := '';

  blnImpPre := False;

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeSEPRodGenerico(False);
    intLinImp := 0;
  End;

  strRisco  := fReplicatorStr('-', 80);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  Reseta;
  Imp(Cond_10CPI(False), False);
  Imp(CPI_12(False), False);
  Imp(Um_Oitavo(True), False);
  Imp(TamPag(intLinPag), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  If (blnCabEmp) Then
  Begin
    pCabEmpresa74Col;

    Imp(Expandido(True) + fPadR(fFormataFone(CadEmp('FONE01').AsString), 74) + Expandido(False) + fPadR(strControle, 5));
    Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + ' Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
    Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString + ' ' + CadEmp('ENDNUM').AsString + ' ' + CadEmp('ENDCMP').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
    Imp(strRisco);
    strControle := '';
  End
  Else
    For intCont := 1 To intQtdLinCabFormAvulso Do Imp('');

  Imp(Expandido(True), False);

  If blnRequisicao Then
    Imp('REQUISICAO - ' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + IIF(blnDocCancelado, ' - CANCELADO ', '') + Expandido(False), blnCabEmp)
  Else
  Begin
    If FEntRet = 'E' Then
      strEntRet := '-ENTREGA'
    Else If FEntRet = 'R' Then
      strEntRet := '-RETIRA'
    Else
      strEntRet := '';

    If Pos(FEspDoc, 'PD_OR_') > 0 Then
      Imp('SEPARACAO - ' + FNumDoc + '-' + FEspDoc + FMsg_CD + IIF(blnDocCancelado, '-CANCELADO', strEntRet + IIF(FatGor('ENTURG').AsString = 'S', '-URGENTE','')) + Expandido(False), blnCabEmp)
    Else If FSepFut Then
      Imp('SEPARACAO ENT.FUT.-' + FNumDoc + '-' + FEspDoc + IIF(MovGer('ENTFAT').AsString <> 'S', '-RETIRA','-ENTREGA') + Expandido(False), blnCabEmp)
    Else
      Imp('SEPARACAO - ' + FNumDoc + '-' + FEspDoc + IIF(blnDocCancelado, ' - CANCELADO ', IIF(MovGer('ENTFAT').AsString <> 'S', ' - RETIRA',' - ENTREGA')) + Expandido(False), blnCabEmp);

  End;

  If (Not blnCabEmp) Then
  Begin
    Imp(fPadL(strControle, 10));
  End;

  If blnDocCancelado Then
  Begin
    If Pos(FEspDoc, 'PD_OR_') > 0 Then
    Begin
      Imp(fPadR(' EM ' + qryFatGor.FieldByName('DTADEL').AsString +
                ' OPERADOR: ' + qryFatGor.FieldByName('OPEDEL').AsString +
                ' MOTIVO: ' + qryFatGor.FieldByName('MOTDEL').AsString, 80));
    End Else
    Begin
      Imp(fPadR(' EM ' + qryMovGer.FieldByName('DTADEL').AsString +
                ' OPERADOR: ' + qryMovGer.FieldByName('OPEDEL').AsString +
                ' MOTIVO: ' + qryMovGer.FieldByName('MOTDEL').AsString, 80));
    End;
  End;

  If (Not blnRequisicao) And fCfgSis('CLISEP', varBoolean) Then
  Begin
    strCodCli := 'Codigo: ' + CadSep('CODCLI').AsString + IIF(blnReimpressao, ' "REIMPRESSAO"', '');
    Imp('Cliente..: ' + fPadR(CadSep('NOMCLI').AsString, 38)        + ' ' + strCodCli);
    Imp('Fantasia.: ' + fPadR(CadSep('NOMFAN').AsString, 38));
    Imp('Endereco.: ' + fPadR(CadSep('ENDCLI').AsString, 69));
    Imp('Bairro...: ' + fPadR(CadSep('BAICLI').AsString, 23) + ' CEP: ' + fPadR(fFormataCEP(CadSep('CEPCLI').AsString), 09) + ' Municipio: ' + fPadR(CadSep('CIDCLI').AsString, 30));
    Imp('Ref Entr.: ' + fPadR(CadSep('REFERE').AsString, 38));
    Imp('CGC/CPF..: ' + fPadR(CadSep('CGCCPF').AsString, 38)        + ' IE/RG.: ' + fPadR(CadSep('IES_RG').AsString, 18));

    If (fCfgSis('USACND', varBoolean)) Then
      Imp('Fone.....: ' + fPadR(fFormataFone(CadSep('TELCLI').AsString), 23) + ' Cnd. Pgto: ' + fPadR(CadSep('CONPAG').AsString, 25))
    Else
      Imp('Fone.....: ' + fPadR(fFormataFone(CadSep('TELCLI').AsString), 18));
  End
  Else If (Not blnRequisicao) And blnReimpressao Then
    Imp(fPadR('"REIMPRESSAO"', 69));

  {************************************************}
  {* IMPRIME LOCAL PARA SEPARADOR E HORA (S/N)    *}
  {*********************************************RV*}
  If (Not blnRequisicao) And fCfgSis('LOCSEP', varBoolean) Then
    Imp('Separador: ______________________________ Hora:______');

  If Not fEmptyStr(strEmpFor) Then
    Imp('Emp.Forn.: ' + fPadR(strEmpFor + '-' + fRetNomeEmpresaSelec(strEmpFor), 38));


  If Pos(strModLaySep, '14') > 0 Then
  Begin
    If fCfgSis('SP40CF', varBoolean) Then
      intEspacoCab := 0
    Else
      intEspacoCab := 16;

    strCabLocFis := 'LOC.FISICA ';
    If (strSeLfCo = 'C') Then
      strCabLocFis := 'COMPLEMENTO';

    Imp(Cond_10CPI(True));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    If Pos(FEspDoc, 'TR_') > 0 Then
      Imp('E/S  ' + strCabLocFis + ' ' + IIF(intEspacoCab=0, IIF(FBarSep, 'COD.BARRAS      ', 'COD.FABRICA     '), '') + 'CODIGO      QTDE ' + IIF(blnEmbSep, 'QTD.EMB. ', '') + 'UN DESCRICAO / REFERENCIA          ' + IIF(blnEmbSep, '', '         ') + fstrEspaco('', intEspacoCab) + IIF(fCfgSis('SAIMAR', varBoolean), 'MARCA', '') + '                   ' + IIF(FValSep, 'VR.UNIT    VR.TOTAL', ''))
    Else
      Imp(strCabLocFis + ' ' + IIF(intEspacoCab=0, IIF(FBarSep, 'COD.BARRAS      ', 'COD.FABRICA     '), '') + 'CODIGO      QTDE ' + IIF(blnEmbSep, 'QTD.EMB. ', '') + 'UN DESCRICAO / REFERENCIA          ' + IIF(blnEmbSep, '', '         ') + fstrEspaco('', intEspacoCab) + IIF(fCfgSis('SAIMAR', varBoolean), 'MARCA', '     ') + '                        ' + IIF(FValSep, 'VR.UNIT    VR.TOTAL', ''));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    //  '12345-1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'
  End;

  If strModLaySep = '2' Then
  Begin
    strCabLocFis := 'LOC.FISICA ';
    If (strSeLfCo = 'C') Then
      strCabLocFis := 'COMPLEMENTO';

    Imp(Cond_10CPI(True));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    If Pos(FEspDoc, 'TR_') > 0 Then
      Imp('E/S  ' + strCabLocFis + ' ' + IIF(FBarSep, 'COD.BARRAS                 ', 'COD.FABRICA                ') + 'CODIGO      QTDE ' + IIF(blnEmbSep, 'QTD.EMB. ', '') + 'DESCRICAO / REFERENCIA                      ' + IIF(blnEmbSep, '', '         ') + fstrEspaco('', 0) + IIF(fCfgSis('SAIMAR', varBoolean), 'MARCA            ', '                 ') + ' UN ')
    Else
      Imp(strCabLocFis + ' ' + IIF(FBarSep, 'COD.BARRAS                 ', 'COD.FABRICA                ') + 'CODIGO      QTDE ' + IIF(blnEmbSep, 'QTD.EMB. ', '') + 'DESCRICAO / REFERENCIA                      ' + IIF(blnEmbSep, '', '         ') + fstrEspaco('', 0) + IIF(fCfgSis('SAIMAR', varBoolean), 'MARCA                 ', '                      ') + ' UN ');
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    //  '12345-1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'
  End;

  If strModLaySep = '3' Then
  Begin
    Imp(Cond_10CPI(True));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp('LOC.FISICA  COD.FABRICA                CODIGO       QTDE UN DESCRICAO / REFERENCIA                   VOL. MULT.VEN    SALDO MARCA        ');
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  End;

end;

procedure TImpSepEspecif.pImprimeSepFast;
  Var
    frxDocSep: TfrxReport;
    bln80Col : Boolean;
Begin
  bln80Col := (strColRel = '80') Or (FDesImp = 'V');

  pCriaModuloFatImp();

  With FModuloFatImp Do Begin
    dtsCadSep.DataSet := FDadSep;
    frxCadEmp.DataSet := qryCadEmp;
    frxMovGer.DataSet := qryMovGer;
    frxFatGor.DataSet := qryFatGor;
    frxItens.DataSet  := qryRelatorio;

    If bln80Col Then Begin
      frxDocSep := frxDocSep80;

      If strModLaySep = '4' Then
        frxDocSep := frxDocSep80_Mod4
      Else Begin
        If Pos(FEspDoc, 'PD_OR_') > 0 Then
          TfrxMemoView(frxDocSep.FindObject('dbTitulo')).Text :=
            TfrxMemoView(frxDocSep.FindObject('dbTitulo')).Text + IIF(blnDocCancelado, ' - CANCELADO ', IIF(FatGor('ENTFAT').AsString <> 'S', ' - RETIRA',' - ENTREGA'))
        Else
          TfrxMemoView(frxDocSep.FindObject('dbTitulo')).Text :=
            TfrxMemoView(frxDocSep.FindObject('dbTitulo')).Text + IIF(blnDocCancelado, ' - CANCELADO ', IIF(MovGer('ENTFAT').AsString <> 'S', ' - RETIRA',' - ENTREGA'));
      End;
    End Else begin
      frxDocSep := frxDocSep40;

      If Not (qryFatGor.IsEmpty) then Begin
        TfrxMemoView(frxDocSep.FindObject('rllNumGui')).Text := 'No GUICHE - [frxFatGor."FGO_NUMGUI"]';
      End Else Begin
        frxFatGor.Close;
        TfrxMemoView(frxDocSep.FindObject('rllNumGui')).Text := '';
      end;
    End;

    frxDocSep.PrintOptions.Printer := AnsiReplaceStr(FNomImp,'\\' + fRetNomeRede + '\','');

    If (bln80Col) And (strModLaySep = '4') Then Begin
      If FDesImp = 'V' Then
        pPreviewReport('frmFatVendas_SEP', 'Impressão de separação (alternativa)', frxDocSep)
      Else Begin
        If frxDocSep.PrepareReport Then
        Begin
          frxDocSep.PrintOptions.ShowDialog := fEmptyStr(FNomImp);
          pPrintReport('frmFatVendas_SEP', 'Impressão de separação (alternativa)', FNomImp, frxDocSep);
        End;
      End;
    End Else Begin
      If bln80Col Then
        pAjustaSep80
      Else Begin
        pAjustaSep40;
        frxMatricial.PageBreaks := False;
      End;

      If Not fCfgSis('CLISEP', varBoolean) Then Begin
        If frxDocSep.FindObject('rllCliente') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('rllCliente')).Visible  := False;

        If frxDocSep.FindObject('rlbCodCli') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('rlbCodCli')).Visible   := False;

        If frxDocSep.FindObject('rllSepCli') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('rllSepCli')).Visible   := False;

        If frxDocSep.FindObject('dbCliente') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('dbCliente')).Visible   := False;

        If frxDocSep.FindObject('ChildDadosCliente') <> Nil Then
          frxDocSep.FindObject('ChildDadosCliente').Visible         := False;

        If frxDocSep.FindObject('lblEntrega') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('lblEntrega')).Visible  := False;

        If frxDocSep.FindObject('dbENDENT') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('dbENDENT')).Visible    := False;

        If frxDocSep.FindObject('dbBAIRROENT') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('dbBAIRROENT')).Visible := False;

        If frxDocSep.FindObject('dbCIDADEENT') <> Nil Then
          TfrxMemoView(frxDocSep.FindObject('dbCIDADEENT')).Visible := False;
      End;

      If Not fCfgSis('LOCSEP', varBoolean) Then
        frxDocSep.FindObject('ChildLocSep').Visible := False;

      frxDocSep.FindObject('rllTitValUni').Visible := FValSep;
      frxDocSep.FindObject('rllTitValTot').Visible := FValSep;
      frxDocSep.FindObject('rldValUni').Visible    := FValSep;
      frxDocSep.FindObject('rldValTot').Visible    := FValSep;

      If FDesImp = 'V' Then
        pPreviewReport('frmFatVendas_SEP', 'Impressão de separação (alternativa)', frxDocSep)
      Else Begin
        If frxDocSep.PrepareReport Then
        Begin
          frxDocSep.PrintOptions.ShowDialog := fEmptyStr(FNomImp);
          pPrintReport('frmFatVendas_SEP', 'Impressão de separação (alternativa)', FNomImp, frxDocSep);
        End;
      End;
    End;
  End;

  FreeAndNil(FModuloFatImp);
end;

procedure TImpSepEspecif.pImprime(blnTemSer: Boolean;
                                  strTabela,
                                  strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strCodCli,
                                  strNumPed,
                                  strTransp: String;
                                  fltDebCli: Double;
                                  blnReimpressao: Boolean;
                                  blnDocSep: Boolean = False;
                                  blnComPre: Boolean = False;
                                  blnImpTck: Boolean = False;
                                  str40ColS: String  = '';
                                  strTip_Fc: String  = '';
                                  strOriDoc: String  = '';
                                  strSQLItens: String  = '';
                                  blnValTot: Boolean = False;
                                  blnDocCan: Boolean = False;
                                  strDesImp: String  = 'I';
                                  intCopias: Integer = 1;
                                  blnImpPed: Boolean = False;
                                  blnEnt_CD: Boolean = False;
                                  blnSepFut: Boolean = False;
                                  strEntRet: String = '');
  Var
    blnSepFast: Boolean;
begin
  FDesImp := strDesImp;
  F40ColS := str40ColS;

  fltTotDescItem := 0.0;
  fltTotPed := 0;
  fltUniOri := 0;
  fltUnitar := 0;
  fltIpiPed := 0;
  fltSubPed := 0;
  fltDesPed := 0;

  intQtdVia := intCopias;
  If (intQtdVia > 1) Then
    strNroVia := IntToStr(intNroVia) + 'a' + ' VIA'
  Else
    strNroVia := '';

  If (fEmptyStr(FNomImp)) And (FDesImp <> 'V') Then
  Begin
    Raise Exception.Create('O nome da impressora não está definido!');
  End;

  FDocSep   := blnDocSep;
  FSepFut   := blnSepFut;
  FEntRet   := strEntRet;
  FEnt_CD   := blnEnt_CD;
  FImpTck   := blnImpTck;

  Self.blnComPre := blnCompre;
  Self.blnValTot := blnValTot;
  blnImpPre := True;

  {**********************************}
  {* ATRIBUI A CONFIGURACAO LAYOUT  *}
  {* IMPRESSAO DOS DOCUMENTOS       *}
  {* MEIA FOLHA OU INTEIRA          *}
  {*******************************JC*}
  If blnDocSep Or blnRequisicao Then
  Begin
    blnMeiFol := (fCfgSis('LAYSEP') = '1');
    FValSep   := (fCfgSis('VALSEP') = 'S');
  End
  Else
  If Pos(strEspDoc, 'UC_MI_FF_CS_TR_IF_D1_AJ_EP_TE_TA_CR_') > 0 Then
    blnMeiFol := (fCfgSis('LAYDOC') = '1')
  Else
  If strEspDoc = 'OR' Then
    blnMeiFol := (fCfgSis('LAY_OR') = '1')
  Else
  If strEspDoc = 'PD' Then
    blnMeiFol := (fCfgSis('LAY_PD') = '1')
  Else
  If strEspDoc = 'PR' Then
    blnMeiFol := (fCfgSis('LAY_DR') = '1')
  Else
  If strEspDoc = 'TE' Then
    blnMeiFol := (fCfgSis('LAYTRE') = '1')
  Else
    blnMeiFol := True;

  blnDocCancelado := blnDocCan;

  blnSepFast := False;

  If blnDocSep Or ((blnRequisicao) And (strEspDoc <> 'PD')) Then
  Begin
    If ((strEspDoc <> 'PD') Or
        (Not fCfgSis('LIBPED', varBoolean, IIF(blnFilaEmpDoc, strCodEmp, VS_strCodEmp))) Or
         blnExpedicao Or blnImpPed) Then
    Begin
      If (strColRel = '80') And (strTipImp = 'M') And (FDesImp <> 'V') Then
        blnSepFast := False
      Else
        blnSepFast := True;
    End;
  End;

  Self.blnTemSer := blnTemSer;
  Self.fltDebCli := fltDebCli;

  Self.blnReimpressao := blnReimpressao;

  FTabItens := strTabela;

  If strTabela = 'MOVDET' Then
    strTabela := 'MOVGER '

  Else If strTabela = 'NOTDET' Then
    strTabela := 'NOTGER '

  Else If strTabela = 'FATDOR' Then
    strTabela := 'FATGOR'

  Else If strTabela = 'MOVGAD' Then
    strTabela := 'MOVGAG'

  Else If strTabela = 'DEL_MOVDET' Then
    strTabela := 'DEL_MOVGER '

  Else If strTabela = 'DEL_NOTDET' Then
    strTabela := 'DEL_NOTGER '

  Else If strTabela = 'DEL_FATDOR' Then
    strTabela := 'DEL_FATGOR'

  Else If strTabela = 'ENTDET' Then
    strTabela := 'ENTGER';

  strNomTab := strTabela;

  intPagina    := 0;

  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;

  If Trim(strNumPed) <> '' Then
    FNumPed := 'Pedido No: ' + strNumPed
  Else
    FNumPed := '';

  FTransp := strTransp;

  pCarregaQueryes(strTabela);

  If blnDocSep Or ((blnRequisicao) And (strEspDoc <> 'PD')) Then
  Begin
    If ((strEspDoc <> 'PD') Or
        (Not fCfgSis('LIBPED', varBoolean, IIF(blnFilaEmpDoc, strCodEmp, VS_strCodEmp))) Or
         blnExpedicao Or blnImpPed) Then
    Begin
      strModLaySep := '4';
      blnEmbSep    := fCfgSis('EMBSEP', varBoolean);
      pImprimeSeparacao;
    End;
  End;

  If Not blnSepFast Then
    ClosePrinter(PrinterHandler);
end;

procedure TImpSepEspecif.pImprimeSeparacao;
begin
  Try
    FBarSep := fCfgSis('IDESEP') = '2';
    pCriaClientSeparacao();
    pInicializaDadosSeparacao();

    Try
      If (strColRel = '80') And (strTipImp = 'M') And (FDesImp <> 'V') Then
        pImprimeSEPGenerico()
      Else
        pImprimeSepFast();
    Finally
      FreeAndNil(FDadSep);
    End;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpSepEspecif.pImprimeSeparacao]');
  End;
end;

procedure TImpSepEspecif.pImprimeSEPGenerico;
  Var
    intQtdDiv   : Integer;
    strCodIte   : String;
    intQtdReg   : Integer;
    intEspacoCab: Integer;
    fltVolume   : Real;
    fltSaldo    : Real;
    fltMltVen   : Real;

    procedure pConfigMeiaFolha;
    begin
      intLinPag := 43;
      If Pos(FEspDoc, VS_strNaoCab) > 0 Then
      Begin
        blnCabEmp    := False;
        intQtdFol    := 17;
        intQtdFolOri := 17;
        intQtdAdc    := 8;
      End
      Else
      Begin
        blnCabEmp    := True;
        intQtdFol    := 10;
        intQtdFolOri := 10;
        intQtdAdc    := 8;
      End;
    end;

    procedure pConfigFolhaInteira;
    begin
      intLinPag := 87;
      If Pos(FEspDoc, VS_strNaoCab) > 0 Then
      Begin
        blnCabEmp    := False;
        intQtdFol    := 61;
        intQtdFolOri := 61;
        intQtdAdc    := 8;
      End
      Else
      Begin
        blnCabEmp    := True;
        intQtdFol    := 56;
        intQtdFolOri := 56;
        intQtdAdc    := 8;
      End;
    end;
begin

  intQtdReg := qryRelatorio.RecordCount + fRetQtdItensLinhaInformAdicional(qryRelatorio);

  If blnMeiFol Then
  Begin
    pConfigMeiaFolha;
    If (intQtdReg > intQtdFol) And (fCfgSis('MUDLAY', varBoolean)) Then
      pConfigFolhaInteira;
  End
  Else
    pConfigFolhaInteira;

  If Not blnCabEmp Then
  Begin
    intQtdFol    :=  intQtdFol     - intQtdLinCabFormAvulso;
    intQtdFolOri :=  intQtdFolOri  - intQtdLinCabFormAvulso;
  End;

  If (blnTemSer) Then
  Begin
    Dec(intQtdFol, 2);
    Dec(intQtdFolOri, 2);
  End;

  If Not fEmptyStr(FNumPed) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  blnEntMat := False;

  If (Pos(FEspDoc, 'PD_OR') > 0) Then
  Begin
    If (Not fEmptyStr(FatGor('MENEXP').AsString)) And (fCfgSis('MEEXPD', varBoolean)) Then
    Begin
      Dec(intQtdFol, 4);
      Dec(intQtdFolOri, 4);
    End;

    If (FatGor('CONENT').AsString = 'S') And (Not (fCfgSis('EMPGER', varBoolean))) Then
    Begin
      Dec(intQtdFol, 1);
      Dec(intQtdFolOri, 1);
      blnEntMat := True;
    End;
  End;

  If (Pos(FEspDoc, 'PD_OR_') <= 0) And (fCfgSis('MOSMRE', varBoolean)) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  If (blnEntMat) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  If Not fEmptyStr(FTransp) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  If blnDocCancelado Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdAdc, 1);
    Dec(intQtdFolOri, 1);
  End;

  intQtdPag := 1;

  If (intQtdReg > intQtdFol) Then
  Begin
    intQtdDiv := intQtdReg - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));
      If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
        Inc(intQtdPag);
    Inc(intQtdPag);
  End;

  qryRelatorio.First;
  intIteImp    := 0;
  intTotIteImp := 0;
  fltTotQtd := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri + intQtdAdc) Then
        Begin
          pImprimeSEPCabGenerico;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= intQtdReg) Then
          Begin
            pImprimeSEPCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      If Pos(strModLaySep, '14') > 0 Then
      Begin
        If fCfgSis('SP40CF', varBoolean) Then
          intEspacoCab := 0
        Else
          intEspacoCab := 16;

        strCodIte := fPadR(IIF(strSeLfCo='L', FieldByName('LOCFIS').AsString, FieldByName('COMPLE').AsString), 12) +
                     IIF(intEspacoCab=0, fPadR(IIF(FBarSep, FieldByName('CODBAR').AsString, IIF(strModLaySep = '4',fRetCaracterEsquerda(FieldByName('CODFAB').AsString,'0'),FieldByName('CODFAB').AsString)), 16), '') +
                     fPadR(FieldByName('CODITE').AsString, 08);

        Imp(IIF((Pos(FEspDoc, 'TR_') > 0), fPadR(FieldByName('ENTSAI').AsString, 05), '') + strCodIte +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadL(FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08)) + ' ' +

            IIF(blnEmbSep,
                IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadL(IIF(FieldByName('QTDEMB').AsFloat > 0, FloatToStrF(FieldByName('QTDEMB').AsFloat, ffFixed, 7, 2), ''), 08)) + ' ', '') +

            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadR(FieldByName('UNIDAD').AsString, 02)) + ' ' +

            {********************************************************}
            {* SE FOR ORÇAMENTO E ESTIVER CONFIGURADO PARA UTILIZAR *}
            {* A DESCRIÇÃO SIMPLES, IMPRIME O CAMPO ITE_DESSIM.     *}
            {*****************************************************RV*}
            fPadR(IIF(blnImprimeDescricaoSimplificada, FieldByName('DESSIM').AsString,
                                                       FieldByName('DESITE').AsString),

            IIF(fEmptyStr(FieldByName('CODITE').AsString), 48, IIF(fCfgSis('SAIMAR', varBoolean),40,63))+intEspacoCab - IIF(blnEmbSep, 9, 0)) + ' ' +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', IIF(fCfgSis('SAIMAR', varBoolean), fPadR(FieldByName('DESMAR').AsString, 24), ' ')) +
            IIF(FValSep, fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 11, 2)), 12), '') +
            IIF(FValSep, fPadL(FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 11, 2), 12), ''));

        fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;

        Inc(intIteImp);
        Inc(intTotIteImp);
      End;

      If strModLaySep = '2' Then
      Begin
        strCodIte := fPadR(IIF(strSeLfCo='L', FieldByName('LOCFIS').AsString, FieldByName('COMPLE').AsString), 12) +
                     fPadR(IIF(FBarSep, FieldByName('CODBAR').AsString, FieldByName('CODFAB').AsString), 26) + ' ' +
                     fPadR(FieldByName('CODITE').AsString, 08);
        Imp(strCodIte +

            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadL(FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08)) + ' ' +
            IIF(blnEmbSep,
              IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadL(IIF(FieldByName('QTDEMB').AsFloat > 0, FloatToStrF(FieldByName('QTDEMB').AsFloat, ffFixed, 7, 2), ''), 08)) + ' ', '') +


            fPadR(FieldByName('DESITE').AsString, IIF(fEmptyStr(FieldByName('CODITE').AsString), 48, IIF(fCfgSis('SAIMAR', varBoolean),51,73)) - IIF(blnEmbSep, 9, 0)) + ' ' +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', IIF(fCfgSis('SAIMAR', varBoolean), fPadR(FieldByName('DESMAR').AsString, 22), fPadR('',0))) + '  ' +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '', fPadR(FieldByName('UNIDAD').AsString, 02)));

        fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;

        Inc(intIteImp);
        Inc(intTotIteImp);

      End;

      If strModLaySep = '3' Then
      Begin
        strCodIte := fPadR(IIF(strSeLfCo='L', FieldByName('LOCFIS').AsString, FieldByName('COMPLE').AsString), 12) +
                     fPadR(IIF(FBarSep, FieldByName('CODBAR').AsString, FieldByName('CODFAB').AsString), 26) + ' ' +
                     fPadR(FieldByName('CODITE').AsString, 08);

        If (FieldByName('QTDITE').AsFloat > 0) And (FieldByName('MLTVEN').AsFloat > 0) Then
          fltVolume := FieldByName('QTDITE').AsFloat / FieldByName('MLTVEN').AsFloat
        Else
        Begin
          If (FieldByName('QTDITE').AsFloat > 0) Then
            fltVolume := FieldByName('QTDITE').AsFloat / 1
          Else
            fltVolume := 0;
        End;

        If (FieldByName('SALDOS').AsFloat > 0) And (FieldByName('MLTVEN').AsFloat > 0) Then
          fltSaldo := FieldByName('SALDOS').AsFloat / FieldByName('MLTVEN').AsFloat
        Else
        Begin
          If (FieldByName('SALDOS').AsFloat > 0) Then
            fltSaldo := FieldByName('SALDOS').AsFloat / 1
          Else
            fltSaldo := 0;
        End;

        If FieldByName('MLTVEN').AsFloat = 0 Then
          fltMltVen := 1
        Else
          fltMltVen := FieldByName('MLTVEN').AsFloat;

        Imp(strCodIte +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '         ', fPadL(FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 09)) + ' ' +
            IIF(fEmptyStr(FieldByName('CODITE').AsString), '  ', fPadR(FieldByName('UNIDAD').AsString, 02)) + ' ' +
            fPadR(FieldByName('DESITE').AsString, 36) + ' ' +
            fPadL(FloatToStrF(fltVolume,                     ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08) + ' ' +
            fPadL(FloatToStrF(fltMltVen,                     ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08) + ' ' +
            fPadL(FloatToStrF(fltSaldo,                      ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08) + ' ' +
            fPadR(FieldByName('DESMAR').AsString, 13) );

        fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;

        Inc(intIteImp);
        Inc(intTotIteImp);
      End;

      If Not fEmptyStr(FieldByName('NUMLOT').AsString) then
      Begin
        Imp(fPadR('', Length(strCodIte)) + VS_strLotImp + ': ' + FieldByName('NUMLOT').AsString);
        Inc(intIteImp);
        Inc(intTotIteImp);
      End;

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimeSEPCabGenerico;
  End;

  pImprimeSEPRodGenerico(True);
end;

procedure TImpSepEspecif.pImprimeSEPRodGenerico(blnTotal: Boolean);
  Var
    intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    If Not fEmptyStr(FTransp) Then
      Imp(fPadL('QUANTIDADE TOTAL: ', 36) + fPadL(FloatToStrF(fltTotQtd, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08) + fPadL('TRANSPORTADORA: ' + FTransp, 93))
    Else
      Imp(fPadL('QUANTIDADE TOTAL: ', 36) + fPadL(FloatToStrF(fltTotQtd, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 08));

    Imp(CadSep('SPESOS').AsString + fPadL('ENTREGA: ' + CadSep('ENDENT').AsString, 137 - Length(CadSep('SPESOS').AsString)));

    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');

    If Not (FEspDoc = 'BR') Then
    Begin

      If (Pos(FEspDoc, 'PD_OR_') > 0) Or fEmptyStr(Trim(fTiraCaracEspeciais(CadSep('PROFIS').AsString))) Then
        Imp(fPadR('Vendedor.: ' + CadSep('VENDED').AsString, 121)  + fPadR('Data: '   + CadSep('DTAENT').AsString, 16))
      Else
        Imp(fPadR('Vendedor.: ' + CadSep('VENDED').AsString + '  ', 61) + IIF(fCfgSis('IMPPRO', varBoolean), fPadR('Profissi.: ' + CadSep('PROFIS').AsString, 60), fPadR(' ', 60)) + fPadR('Data: '   + CadSep('DTAENT').AsString, 16));

    End;

    If (fCfgSis('USADIG', varBoolean)) Then
      Imp(fPadR('Digitador: ' + CadSep('DIGITA').AsString, 137))
    Else
      Imp('');

    If Not fEmptyStr(FNumPed) Then
      Imp(fPadR(FNumPed, 137));

    Imp(fPadR('Mensagem.: ' + CadSep('MEN001').AsString, 121)  + fPadR('Hora:   ' + CadSep('HORENT').AsString, 16));
    Imp(fPadR('           ' + CadSep('MEN002').AsString, 137));

    If FEspDoc = 'EP' Then
    Begin
      Imp(fPadR('           ' + CadSep('MEN003').AsString, 137));
      Imp(fPadR('           ' + CadSep('MEN004').AsString, 137));
      Imp(fPadR('           ' + CadSep('MEN005').AsString, 137));
    End;

    If fCfgSis('EXPSEP', varBoolean) And (Pos(FEspDoc, 'PD_OR_') > 0) Then
    Begin

      If (Not fEmptyStr(FatGor('MENEXP').AsString)) Then
      Begin
        Imp(fPadR('           ' + FatGor('MENEXP').AsString, 137));
        Imp(fPadR('           ' + FatGor('MENEX2').AsString, 137));
        Imp(fPadR('           ' + FatGor('MENEX3').AsString, 137));
        Imp(fPadR('           ' + FatGor('MENEX4').AsString, 137));
      End;

    End;

    If Pos(FEspDoc, 'PD_OR_') <= 0 Then
    Begin

      If fCfgSis('MOSMRE', varBoolean) Then
        Imp(CadSep('ROMANE').AsString);

    End;

    If (blnEntMat) Then
      Imp('ENTREGUE PELA MATRIZ');

  End
  Else
  Begin
    Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  Eject;
end;

procedure TImpSepEspecif.pIniciaDadosSepOutros;
begin
  With FDadSep Do
  Begin
    FieldByName('CODVEN').AsString := MovGer('CODVEN').AsString;
    FieldByName('CODDIG').AsString := MovGer('CODDIG').AsString;
    FieldByName('DTAENT').AsString := Movger('DTAENT').AsString;
    FieldByName('HORENT').AsString := Movger('HORENT').AsString;
    FieldByName('MEN001').AsString := Movger('MEN001').AsString;
    FieldByName('MEN002').AsString := Movger('MEN002').AsString;

    If FEspDoc = 'EP' Then
    Begin
      FieldByName('MEN003').AsString := Movger('MEN003').AsString;
      FieldByName('MEN004').AsString := Movger('MEN004').AsString;
      FieldByName('MEN005').AsString := Movger('MEN005').AsString;
    End Else
    Begin
      FieldByName('MEN003').AsString := '';
      FieldByName('MEN004').AsString := '';
      FieldByName('MEN005').AsString := '';
    End;

    If (qryRelatorio.RecordCount > 0) Then
      FieldByName('PROFIS').AsString := qryRelatorio.FieldByName('DET_CODDIV').AsString + ' - ' +
                                        fRetNomProfissional(qryRelatorio.FieldByName('DET_CODDIV').AsString)
    Else
      FieldByName('PROFIS').AsString := '';

    FieldByName('MENEXP').AsString := '';
    FieldByName('MENEX2').AsString := '';
    FieldByName('MENEX3').AsString := '';
    FieldByName('MENEX4').AsString := '';

    If Not blnRequisicao Then
    Begin
      FieldByName('ENTFAT').AsString := Movger('ENTFAT').AsString;
      FieldByName('DTENTR').AsString := Movger('DTENTR').AsString;
    End;

    FieldByName('PESBRU').AsString := FormatFloat('#,###0.000', Movger('PESBRU').AsFloat);
    FieldByName('PESLIQ').AsString := FormatFloat('#,###0.000', Movger('PESLIQ').AsFloat);

    If fCfgSis('MOSMRE', varBoolean) And Not blnRequisicao Then
    Begin
      FieldByName('ROMANE').AsString := 'GERAR ROMANEIO DE ENTREGA: ' + IIF(MovGer('ENTFAT').AsString = 'S', 'SIM', 'NAO') + ' DT. ENTREGA: ' + MovGer('DTENTR').AsString;
      FieldByName('ROMA40').AsString := 'ROMAN. ENT.: ' + IIF(MovGer('ENTFAT').AsString = 'S', 'SIM', 'NAO') + ' DT. ENT.: ' + MovGer('DTENTR').AsString;
    End
    Else
    Begin
      FieldByName('ROMANE').AsString := '';
      FieldByName('ROMA40').AsString := '';
    End;

    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
        FieldByName('CONPAG').AsString := fFormataCondPag(MovGer('CONPAG').AsString)
      Else
        FieldByName('CONPAG').AsString := 'A VISTA';
    End;

  End;
end;

procedure TImpSepEspecif.pIniciaDadosSepPDOR;
begin
  With FDadSep Do
  Begin
    FieldByName('CODVEN').AsString := FatGor('CODVEN').AsString;

    If (qryRelatorio.RecordCount > 0) Then
      FieldByName('CODVE2').AsString := qryRelatorio.FieldByName('CODVE2').AsString
    Else
      FieldByName('CODVE2').Clear();

    FieldByName('CODDIG').AsString := FatGor('CODDIG').AsString;
    FieldByName('DTAENT').AsString := FatGor('DTAENT').AsString;
    FieldByName('HORENT').AsString := FatGor('HORENT').AsString;
    FieldByName('MEN001').AsString := FatGor('MEN001').AsString;
    FieldByName('MEN002').AsString := FatGor('MEN002').AsString;
    FieldByName('MEN003').AsString := '';
    FieldByName('MEN004').AsString := '';
    FieldByName('MEN005').AsString := '';
    FieldByName('PROFIS').AsString := '';

    If fCfgSis('EXPSEP', varBoolean) Then
    Begin
      FieldByName('MENEXP').AsString := FatGor('MENEXP').AsString;
      FieldByName('MENEX2').AsString := FatGor('MENEX2').AsString;
      FieldByName('MENEX3').AsString := FatGor('MENEX3').AsString;
      FieldByName('MENEX4').AsString := FatGor('MENEX4').AsString;
    End
    Else
    Begin
      FieldByName('MENEXP').AsString := '';
      FieldByName('MENEX2').AsString := '';
      FieldByName('MENEX3').AsString := '';
      FieldByName('MENEX4').AsString := '';
    End;

    FieldByName('ENTFAT').AsString := '';
    FieldByName('DTENTR').AsString := '';
    FieldByName('PESBRU').AsString := FormatFloat('#,###0.000', FatGor('PESBRU').AsFloat);
    FieldByName('PESLIQ').AsString := FormatFloat('#,###0.000', FatGor('PESLIQ').AsFloat);
    FieldByName('ROMANE').AsString := '';
    FieldByName('ROMA40').AsString := '';

    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      If (fStatusCndPag(FatGor('CONPAG').AsString) = A_PRAZO) Then
        FieldByName('CONPAG').AsString := fFormataCondPag(FatGor('CONPAG').AsString)
      Else
        FieldByName('CONPAG').AsString := 'A VISTA';
    End;
  End;
end;

procedure TImpSepEspecif.pInicializaDadosSeparacao;
  Var
    sltMensagem,
    sltMensage2: TStringList;
    intContador: Integer;
    strSalto   : String;
    intQtdSal  : Integer;
    fCampos: function(strCampo: String): TField of object;
Begin
  With FDadSep Do
  Begin
    Insert;

    If Pos(FEspDoc, 'PD_OR_') > 0 Then
      fCampos := FatGor
    Else
      fCampos := MovGer;

    If FDesImp = 'V' Then
      FieldByName('REIMPR').AsString := IIF(blnReimpressao, '"REIMPRESSÃO"', '')
    Else
      FieldByName('REIMPR').AsString := IIF(blnReimpressao, '"REIMPRESSAO"', '');

    If Pos(FEspDoc, 'PD_OR_') > 0 Then
      FieldByName('ENTURG').AsString := FatGor('ENTURG').AsString;

    FieldByName('SEPFUT').AsString := IIF(FSepFut, 'S', 'N');
    FieldByName('NUMDOC').AsString := FNumDoc;
    FieldByName('ESPDOC').AsString := FEspDoc;
    FieldByName('ENT_CD').AsString := FMsg_CD;
    FieldByName('TRANSP').AsString := FTransp;

    If Pos(FEspDoc, 'PD_OR_') > 0 Then
      pIniciaDadosSepPDOR
    Else
      pIniciaDadosSepOutros;

    pCarregaDadosClienteSeparacao;

    If fCfgSis('EXIPES',varBoolean) Then
    Begin
      FieldByName('SPESOS').AsString := 'Peso Bruto: ' + CadSep('PESBRU').AsString + ' - Peso Liquido: ' +  CadSep('PESLIQ').AsString + ' ';
      FieldByName('SPES40').AsString := 'Pes.Bru: ' + CadSep('PESBRU').AsString + ' - Pes.Liq: ' +  CadSep('PESLIQ').AsString + ' ';
    End Else
    Begin
      FieldByName('SPESOS').AsString := '';
      FieldByName('SPES40').AsString := '';
    End;

    If (Not fClienteConsumidor(CadCli('NOMCLI').AsString, True, True)) Then
    Begin
      FieldByName('ENDENT').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('ENDERE').AsString, CadCli('ENDENT').AsString) + ' - ' +
                                        IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('BAIRRO').AsString, CadCli('BAIENT').AsString) + ' - ' +
                                        IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('NOMCID').AsString, CadCli('NCIDEN').AsString) + ' - ' +
                                        IIF(fEmptyStr(CadCli('ENDENT').AsString), fRetNomCidade(CadCli('CODCID').AsString,1), CadCli('NESTEN').AsString) +
                                        IIF(Not fEmptyStr(CadCli('REFENT').AsString), ' - REF.: ' + CadCli('REFENT').AsString, '');
    End
    Else
    Begin
      FieldByName('ENDENT').AsString := fCampos('ENDCON').AsString + ' - ' +
                                        fCampos('BAICON').AsString + ' - ' +
                                        fRetNomCidade(fCampos('CIDCON').AsString, 0) + '-' + fRetNomCidade(fCampos('CIDCON').AsString, 1);
    End;

    FieldByName('ENDTRA').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('ENDERE').AsString, CadCli('ENDENT').AsString);
    FieldByName('BAITRA').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('BAIRRO').AsString, CadCli('BAIENT').AsString);
    FieldByName('CIDTRA').AsString := IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('NOMCID').AsString, CadCli('NCIDEN').AsString) + ' - ' +
                                      IIF(fEmptyStr(CadCli('ENDENT').AsString), fRetNomCidade(CadCli('CODCID').AsString,1), CadCli('NESTEN').AsString);

    CadSep('VENDED').AsString := CadSep('CODVEN').AsString + ' - ' + fRetNomVendRep(CadSep('CODVEN').AsString);
    CadSep('VENDE2').AsString := CadSep('CODVE2').AsString + ' - ' + fRetNomVendRep(CadSep('CODVE2').AsString);
    CadSep('DIGITA').AsString := CadSep('CODDIG').AsString + ' - ' + fRetNomVendRep(CadSep('CODDIG').AsString);

    sltMensagem := TStringList.Create;
    sltMensagem.Clear;

    For intContador := 1 To 5 Do
      If Not fEmptyStr(CadSep('MEN00' + IntToStr(intContador)).AsString) Then
        sltMensagem.Add(CadSep('MEN00' + IntToStr(intContador)).AsString);

    CadSep('MENSAG').AsString := sltMensagem.Text;
    FreeAndNil(sltMensagem);

    sltMensage2 := TStringList.Create;
    sltMensage2.Clear;

    If Not fEmptyStr(CadSep('MENEXP').AsString) Then
      sltMensage2.Add(CadSep('MENEXP').AsString);

    If Not fEmptyStr(CadSep('MENEX2').AsString) Then
      sltMensage2.Add(CadSep('MENEX2').AsString);

    If Not fEmptyStr(CadSep('MENEX3').AsString) Then
      sltMensage2.Add(CadSep('MENEX3').AsString);

    If Not fEmptyStr(CadSep('MENEX4').AsString) Then
      sltMensage2.Add(CadSep('MENEX4').AsString);

    CadSep('MENSA2').AsString := sltMensage2.Text;
    FreeAndNil(sltMensage2);

    strSalto := '';
    intQtdSal := fCfgSis('QTDSAL', varInteger);
    For intContador := 1 To intQtdSal Do
      strSalto := strSalto + '       ' + #13#10;

    FieldByName('SALTO').AsString := strSalto;

    If (strNomTab = 'FATGOR') Then
    Begin
      FieldByName('PARCEL').AsString := fRetornaParcelasExp;
      FieldByName('FINANC').AsFloat := fRetornaFinanceiroExp(FatGor('CODCND').AsString);
    End;

    If strModLaySep = '4' Then
      FieldByName('CNDMD4').AsString := fRetornaConPagModelo4(fCampos('CONPAG').AsString);

    FieldByName('FRETE_').AsString := fCampos('TIPFRE').AsString + '-' + fRetornaFrete(fCampos('TIPFRE').AsString);
    FieldByName('PORDES').AsFloat := fCampos('PORDES').AsFloat;
    FieldByName('VLRCON').AsFloat := fCampos('VLRCON').AsFloat;
    FieldByName('DESESP').AsFloat := fCampos('DESESP').AsFloat;
    FieldByName('TOTPRO').AsFloat := fCampos('TOTPRO').AsFloat;
    FieldByName('TOTFRE').AsFloat := fCampos('TOTFRE').AsFloat;
    FieldByName('TOTIPI').AsFloat := fCampos('TOTIPI').AsFloat;

    Post;
  End;
end;

procedure TImpSepEspecif.Reseta;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Exit;
  End;

  Imp(#27 + '@', False);
  Imp(#18 + #27 + #80, False);
end;

function TImpSepEspecif.TamPag(intMaxLin: Integer): String;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Result := '';
    Exit;
  End;

  Result := #27 + 'C' + Chr(intMaxLin);
end;

function TImpSepEspecif.Um_Oitavo(blnLiga: Boolean): String;
begin
  If Assigned(impNaoFiscal) Then
  Begin
    Result := '';
    Exit;
  End;

  If blnLiga Then
     Result := #27 + '0'
  Else
     Result := #27 + '2';
end;

end.
