unit untRelFiscMapaResumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters,
  RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel, strUtils,
  ExtCtrls, Buttons, BitBtnLockedIncrem, Mask, MaskEditFocus, untGeraExcel,
  untExcel, DB, Uni, frxExportCSVTestabilidade, untTypesSistema, Math,
  UniClientDataSet, Datasnap.DBClient, Vcl.ComCtrls;

type
  TfrmRelFiscMapaResumo = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCodEcf: TEditFocus;
    edtDesEcf: TEditFocus;
    frxReport_M: TfrxReport;
    frxReport_J: TfrxReport;
    Shape1: TShape;
    frxReport_M_CAT55: TfrxReport;
    cdsNovoMapaResumo: TUniClientDataSet;
    cdsNovoMapaResumoECF_CODECF: TStringField;
    cdsNovoMapaResumoRDZ_CPOFIM: TStringField;
    cdsNovoMapaResumoRDZ_VALDIA: TFloatField;
    cdsNovoMapaResumoRDZ_TOTCNL: TFloatField;
    cdsNovoMapaResumoVALOR_CONTABIL: TFloatField;
    cdsNovoMapaResumoRDZ_VALOST: TFloatField;
    cdsNovoMapaResumoRDZ_ISENTO: TFloatField;
    cdsNovoMapaResumoRDZ_BASCL7: TFloatField;
    cdsNovoMapaResumoRDZ_BASC12: TFloatField;
    cdsNovoMapaResumoRDZ_BASC18: TFloatField;
    cdsNovoMapaResumoRDZ_BASC25: TFloatField;
    cdsNovoMapaResumoRDZ_TOTIMP: TFloatField;
    cdsNovoMapaResumoRDZ_NUMCRZ: TFloatField;
    frxRel_M_CAT55: TfrxDBDataset;
    cdsNovoMapaResumoRDZ_NROCOO: TStringField;
    chkLayoutCat55: TCheckBox;
    frxReport_J_CAT55: TfrxReport;
    cdsNovoMapaResumoRDZ_DTAMOV: TDateField;
    chkPreencheCabecalho: TCheckBox;
    edtNumRel: TEditFocus;
    Label4: TLabel;
    rgMapaResumo: TRadioGroup;
    cdsNovoMapaResumoRDZ_PAGINA: TStringField;
    ColorLabel2: TColorLabel;
    pgbProgresso: TProgressBar;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkPreencheCabecalhoClick(Sender: TObject);
    procedure chkLayoutCat55Click(Sender: TObject);
    procedure edtCodEcfExit(Sender: TObject);
    procedure edtCodEcfKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    QryRelatorio : TUniQuery;
    arrCadEcf : TConsultasArray;
    strCodEcf: String;

    procedure pAtivaTela(blnAtiva: Boolean);

    function fCarregaReducoesZ: String;
    function fCarregaDadosEmpresa: String;
    function fCarregaTotalizadores: String;
    procedure pGeraNovoMapaResumo;

    procedure pGerarExcel;

    procedure pImpTitGrupo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);

    procedure pConfiguraTipMapaResumo(frxRep: TfrxReport);

    function fRetornaIESformatada(strIES, strEstado: String): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

  function fRetModEcf(strCodEcf: String): String;

var
  frmRelFiscMapaResumo: TfrmRelFiscMapaResumo;

implementation

uses untFuncoesSimples, untIFuncoes, untFuncoesGenerica, MaskUtils, untConsultas,
untFuncoesConsulta;

{$R *.dfm}

function fRetModEcf(strCodEcf: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT ECF_MODELO FROM CADECF WHERE ECF_CODECF = :CODECF');
    qryAux.ParamByName('CODECF').AsString := strCodEcf;
    qryAux.Open;

    Result := qryAux.FieldByName('ECF_MODELO').AsString;
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmRelFiscMapaResumo.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    frxRep: TfrxReport;
    qryAux: TUniQuery;
    FPais: TPais;
begin
  inherited;

  pAtivaTela(False);

  If blnImprime And chkLayoutCat55.Checked Then
  Begin
    If strTipImp = 'M' Then
    Begin
      fMensagem('AVISO', 'Essa opção só permite a visualização e impressão em uma impressora a jato!', ['OK']);
      pAtivaTela(True);
      Exit;
    End;

    If edtDestino.Text = 'E' Then
    Begin
      fMensagem('AVISO', 'Essa opção não permite exportação para excel!', ['OK']);
      pAtivaTela(True);
      Exit;
    End;

    FPais := fSetaPais;

    cdsNovoMapaResumo.EmptyDataSet;

    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(fCarregaDadosEmpresa);
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.Open;

      pGeraNovoMapaResumo;

      If cdsNovoMapaResumo.RecordCount <= 0 Then
      Begin
        pTabelaVazia;
        pAtivaTela(True);
        pSetFocus(mskDtaIni);
        Exit;
      End;

      cdsNovoMapaResumo.First;

      frxRep := frxReport_J_CAT55;

      TfrxMemoView(frxRep.FindObject('Memo50')).Visible:= False;
      TfrxMemoView(frxRep.FindObject('Memo51')).Visible:= False;
      TfrxMemoView(frxRep.FindObject('Memo52')).Visible:= False;

      frxRep.Script.Variables['NOMEMP'] := '';
      frxRep.Script.Variables['ENDERECO'] := '';
      frxRep.Script.Variables['MUNICIPIO'] := '';
      frxRep.Script.Variables['UFEMP'] := '';
      frxRep.Script.Variables['CGC'] := '';
      frxRep.Script.Variables['INSC_EST'] := '';

      If chkPreencheCabecalho.Checked Then
      Begin
        frxRep.Script.Variables['NOMEMP'] := qryAux.FieldByName('EMP_NOMFAN').AsString;
        frxRep.Script.Variables['ENDERECO'] := qryAux.FieldByName('EMP_ENDERE').AsString;
        frxRep.Script.Variables['MUNICIPIO'] := qryAux.FieldByName('CID_NOMCID').AsString;
        frxRep.Script.Variables['UFEMP'] := qryAux.FieldByName('CID_ESTADO').AsString;
        frxRep.Script.Variables['CGC'] := fFormataCpfCgc(qryAux.FieldByName('EMP_C_G_C_').AsString, FPais);
        frxRep.Script.Variables['INSC_EST'] := fRetornaIESformatada(qryAux.FieldByName('EMP_I_E_S_').AsString, qryAux.FieldByName('CID_ESTADO').AsString);

        pConfiguraTipMapaResumo(frxRep);
      End;

      frxRep.PrintOptions.PrintMode := pmScale;
      frxRep.PrintOptions.PrintOnSheet := 9;

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRep)
      Else If edtDestino.Text = 'I' Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxRep);
    Finally
      qryAux.Free;
    End;

    pAtivaTela(True);
    Exit;
  End;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(ECF_CODECF, IFNULL(ECF_NUMSER,""), RDZ_DTAMOV) AS QUEBRA, ';
    strSQL := strSQL + '  CONCAT(ECF_CODECF, "-", ';
    strSQL := strSQL + '         IFNULL(ECF_MODELO, "MODELO EM BRANCO"), "-", ';
    strSQL := strSQL + '         IFNULL(ECF_NUMSER, "NRO. SERIE EM BRANCO")) AS ECF_DESECF, ';
    strSQL := strSQL + '  RDZ_DTAMOV, ';
    strSQL := strSQL + '  RDZ_DTAMOV, ';
    strSQL := strSQL + '  RDZ_QTDRDZ, ';
    strSQL := strSQL + '  RDZ_VALDIA, ';
    strSQL := strSQL + '  IFNULL(RDZ_TOTCNL,0) AS RDZ_TOTCNL, ';
    strSQL := strSQL + '  IFNULL(RDZ_TOTDSC,0) AS RDZ_TOTDSC, ';
    strSQL := strSQL + '  RDZ_TOTCTB, ';
    strSQL := strSQL + '  CONCAT(TOT_CODTOT, "-", TOT_DESTOT) AS TOT_DESTOT, ';
    strSQL := strSQL + '  TOT_BASIMP, ';
    strSQL := strSQL + '  TOT_ALQIMP, ';
    strSQL := strSQL + '  TOT_VALIMP  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRDZ ';
    strSQL := strSQL + '  JOIN RDZTOT ON TOT_NUMCRZ = RDZ_QTDRDZ AND ';
    strSQL := strSQL + '                 TOT_CODECF = RDZ_CODECF ';
    strSQL := strSQL + '  JOIN CADECF ON ECF_CODECF = RDZ_CODECF ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + fStrLocate(edtCodEcf, arrCadEcf, 'RDZ_CODECF', 'CODECF');

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RDZ_CODECF, RDZ_DTAMOV, TOT_NUMTOT ';

    QryRelatorio.SQL.Clear;
    QryRelatorio.SQL.Add(strSQL);

    QryRelatorio.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    QryRelatorio.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(edtCodEcf.Text) Then
      pSetaParam(edtCodEcf.Text, arrCadEcf, strCodEcf, 'CODECF', QryRelatorio);

    QryRelatorio.Open;

    If Not QryRelatorio.IsEmpty Then
    Begin
      If edtDestino.Text = 'E' Then
      Begin
        pGerarExcel;
      End
      Else
      Begin
        If strTipImp = 'M' Then
        Begin
          frxRep := frxReport_M;
        End
        Else
        Begin
          frxRep := frxReport_J;
        End;

        frxRep.Script.Variables['NOMREL'] := 'MAPA RESUMO';
        frxRep.Script.Variables['CODECF'] := fStrTitulo(edtCodEcf.Text, edtDesEcf, arrCadEcf, strCodEcf, '', TRUE);
        frxRep.PrepareReport;
        If edtDestino.Text = 'V' Then
        Begin
          pPreviewReport(Self.Name, Self.Caption, frxRep);
        End
        Else
        Begin
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxRep);
        End;
      End;
    End
    Else
    Begin
      pTabelaVazia;
      pSetFocus(mskDtaIni);
    End;
  End;

  pAtivaTela(True);
end;

function TfrmRelFiscMapaResumo.fCarregaDadosEmpresa: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_NOMEMP, ';
  strSQL := strSQL + '  EMP_NOMFAN, ';
  strSQL := strSQL + '  EMP_ENDERE, ';
  strSQL := strSQL + '  EMP_C_G_C_, ';
  strSQL := strSQL + '  EMP_I_E_S_, ';
  strSQL := strSQL + '  CID_NOMCID, ';  
  strSQL := strSQL + '  CID_ESTADO ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + 'WHERE EMP_CODEMP = :CODEMP ';

  Result := strSQL;
end;

function TfrmRelFiscMapaResumo.fCarregaReducoesZ: String;
  Var
    strSQL: String;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ECF_CODECF, ';
  strSQL := strSQL + '  RDZ_NROCOO, ';
  strSQL := strSQL + '  RDZ_CPOFIM, ';
  strSQL := strSQL + '  RDZ_QTDRDZ, ';
  strSQL := strSQL + '  IFNULL(RDZ_VALDIA, 0) AS RDZ_VALDIA, ';
  strSQL := strSQL + '  RDZ_DTAMOV, ';
  strSQL := strSQL + '  IFNULL(RDZ_TOTCNL, 0) - IFNULL(RDZ_TOTDSC, 0) AS RDZ_TOTCNL, ';
  strSQL := strSQL + '  IFNULL(RDZ_VALDIA, 0) - IFNULL(RDZ_TOTCNL, 0) - IFNULL(RDZ_TOTDSC, 0) AS VALOR_CONTABIL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADRDZ ';
  strSQL := strSQL + '  JOIN CADECF ';
  strSQL := strSQL + '   ON ECF_CODECF = RDZ_CODECF ';
  strSQL := strSQL + 'WHERE RDZ_DTAMOV BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND RDZ_CODEMP = :CODEMP ';

  strSQL := strSQL + fStrLocate(edtCodEcf, arrCadEcf, 'RDZ_CODECF', 'CODECF');

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  RDZ_DTAMOV ';

  Result := strSQL;
end;

function TfrmRelFiscMapaResumo.fCarregaTotalizadores: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(TOT_BASIMP, 0) AS TOT_BASIMP, ';
  strSQL := strSQL + '  IFNULL(TOT_ALQIMP, 0) AS TOT_ALQIMP, ';
  strSQL := strSQL + '  IFNULL(TOT_VALIMP, 0) AS TOT_VALIMP, ';
  strSQL := strSQL + '  TOT_CODTOT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RDZTOT ';
  strSQL := strSQL + 'WHERE TOT_NUMCRZ = :NUMCRZ ';
  strSQL := strSQL + '  AND TOT_CODECF = :CODECF ';

  Result := strSQL;
end;

procedure TfrmRelFiscMapaResumo.pConfiguraTipMapaResumo(frxRep: TfrxReport);
begin
  If rgMapaResumo.ItemIndex = 0 Then
  Begin
    TfrxMemoView(frxRep.FindObject('Memo50')).Visible:= True;
    TfrxMemoView(frxRep.FindObject('Memo51')).Visible:= False;
    TfrxMemoView(frxRep.FindObject('Memo52')).Visible:= False;
  End
  Else If rgMapaResumo.ItemIndex = 1 Then
  Begin
    TfrxMemoView(frxRep.FindObject('Memo50')).Visible:= False;
    TfrxMemoView(frxRep.FindObject('Memo51')).Visible:= True;
    TfrxMemoView(frxRep.FindObject('Memo52')).Visible:= False;
  End
  Else
  Begin
    TfrxMemoView(frxRep.FindObject('Memo50')).Visible:= False;
    TfrxMemoView(frxRep.FindObject('Memo51')).Visible:= False;
    TfrxMemoView(frxRep.FindObject('Memo52')).Visible:= True;
  End;
end;

procedure TfrmRelFiscMapaResumo.pAtivaTela(blnAtiva: Boolean);
begin
  pnlDados.Enabled := blnAtiva;
  pnlBotoes.Enabled := blnAtiva;
end;

procedure TfrmRelFiscMapaResumo.pGeraNovoMapaResumo;
  function fPadZ(strTexto:variant; Quant:integer): String;
    Var
      i, Tam: Integer;
  begin
    if VarType(strTexto) = varDouble then
      strTexto := Trim(fTiraCaracEspeciais(floatToStr(strTexto), False, True))
    else if VarType(strTexto) = varInteger then
      strTexto := Trim(fTiraCaracEspeciais(IntToStr(strTexto), False, True))
    else
    begin
    end;

    Tam := Length(strTexto);
    if (Quant - Tam) > 0 then
      for i:=1 to (Quant - Tam) do
        strTexto := '0' + strTexto;

    Result := RightStr(strTexto, Quant);
  end;

  Var
    fltImpostoDebitado: Double;
    qryReducao, qryTotalizador: TUniQuery;
    intContador: Integer;
begin
  fltImpostoDebitado := 0;

  If fEmptyStr(edtNumRel.Text) Then
    intContador := 1
  Else
   intContador := StrToInt(edtNumRel.Text);

  qryReducao := fCriaQuery(Nil);
  qryTotalizador := fCriaQuery(Nil);
  Try
    qryTotalizador.Close;
    qryTotalizador.SQL.Clear;
    qryTotalizador.SQL.Add(fCarregaTotalizadores);

    With qryReducao Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fCarregaReducoesZ);
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(edtCodEcf.Text) Then
        pSetaParam(edtCodEcf.Text, arrCadEcf, strCodEcf, 'CODECF', qryReducao);

      Open;

      First;
      While Not Eof Do
      Begin
        cdsNovoMapaResumo.Append;
        cdsNovoMapaResumoRDZ_DTAMOV.AsDateTime := FieldByName('RDZ_DTAMOV').AsDateTime;
        cdsNovoMapaResumoRDZ_PAGINA.AsString :=  fPadZ(IntToStr(intContador), 006);
        cdsNovoMapaResumoECF_CODECF.AsString := FieldByName('ECF_CODECF').AsString;
        cdsNovoMapaResumoRDZ_NROCOO.AsString := FieldByName('RDZ_NROCOO').AsString;
        cdsNovoMapaResumoRDZ_CPOFIM.AsString := FieldByName('RDZ_CPOFIM').AsString;
        cdsNovoMapaResumoRDZ_VALDIA.AsFloat := FieldByName('RDZ_VALDIA').AsFloat;
        cdsNovoMapaResumoRDZ_TOTCNL.AsFloat := FieldByName('RDZ_TOTCNL').AsFloat;
        cdsNovoMapaResumoVALOR_CONTABIL.AsFloat := FieldByName('VALOR_CONTABIL').AsFloat;
        cdsNovoMapaResumoRDZ_NUMCRZ.AsString := FieldByName('RDZ_QTDRDZ').AsString;

        cdsNovoMapaResumoRDZ_VALOST.AsFloat := 0;
        cdsNovoMapaResumoRDZ_ISENTO.AsFloat := 0;

        cdsNovoMapaResumoRDZ_BASCL7.AsFloat := 0;
        cdsNovoMapaResumoRDZ_BASC12.AsFloat := 0;
        cdsNovoMapaResumoRDZ_BASC18.AsFloat := 0;
        cdsNovoMapaResumoRDZ_BASC25.AsFloat := 0;

        qryTotalizador.ParamByName('NUMCRZ').AsString := FieldByName('RDZ_QTDRDZ').AsString;
        qryTotalizador.ParamByName('CODECF').AsString := FieldByName('ECF_CODECF').AsString;
        qryTotalizador.Open;

        qryTotalizador.First;
        While Not qryTotalizador.Eof Do
        Begin
          fltImpostoDebitado := 0;

          If LeftStr(qryTotalizador.FieldByName('TOT_CODTOT').AsString, 1) = 'F' Then
            cdsNovoMapaResumoRDZ_VALOST.AsFloat := cdsNovoMapaResumoRDZ_VALOST.AsFloat + qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;

          If LeftStr(qryTotalizador.FieldByName('TOT_CODTOT').AsString, 1) = 'I' Then
            cdsNovoMapaResumoRDZ_ISENTO.AsFloat := cdsNovoMapaResumoRDZ_ISENTO.AsFloat + qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;

          If qryTotalizador.FieldByName('TOT_ALQIMP').AsFloat = 7 Then
            cdsNovoMapaResumoRDZ_BASCL7.AsFloat := qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;

          If qryTotalizador.FieldByName('TOT_ALQIMP').AsFloat = 12 Then
            cdsNovoMapaResumoRDZ_BASC12.AsFloat := qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;;

          If qryTotalizador.FieldByName('TOT_ALQIMP').AsFloat = 18 Then
            cdsNovoMapaResumoRDZ_BASC18.AsFloat := qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;;

          If qryTotalizador.FieldByName('TOT_ALQIMP').AsFloat = 25 Then
            cdsNovoMapaResumoRDZ_BASC25.AsFloat := qryTotalizador.FieldByName('TOT_BASIMP').AsFloat;

          fltImpostoDebitado := fltImpostoDebitado + qryTotalizador.FieldByName('TOT_VALIMP').AsFloat;

          qryTotalizador.Next;
        End;

        cdsNovoMapaResumoRDZ_TOTIMP.AsFloat := fltImpostoDebitado;

        cdsNovoMapaResumo.Post;

        qryTotalizador.Close;

        Inc(intContador);

        Next;
      End;
    End;
  Finally
    qryReducao.Free;
    qryTotalizador.Free;
  End;
end;

procedure TfrmRelFiscMapaResumo.pGerarExcel;
  Var
    excel: TGeraExcel;
begin
  excel := TGeraExcel.Create(QryRelatorio, pgbProgresso);

  With excel Do
  Begin
    strNomRel := 'MAPA RESUMO';

    AddFiltro(fStrTituloPeriodo(mskDtaIni, mskDtaFin));
    AddFiltro('ECF: ' + fStrTitulo(edtCodEcf.Text, edtDesEcf, arrCadEcf, strCodEcf, '', TRUE));

    AddQuebra('QUEBRA', '', False);

    AddCampo('TOT_DESTOT', 'TOTALIZADOR');
    AddCampo('TOT_BASIMP', 'Base', 2);
    AddCampo('TOT_ALQIMP', 'Alq.', 2);
    AddCampo('TOT_VALIMP', 'Valor', 2);

    OnImpTitGrupo := pImpTitGrupo;

    If fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);

  End;

  FreeAndNil(excel);

end;

procedure TfrmRelFiscMapaResumo.pImpTitGrupo(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    Escrever(ProximaLinha, 01, 'ECF: ' + Dados.FieldByName('ECF_DESECF').AsString);
    Escrever(LinhaAtual, 02, 'DATA: ' + FormatDateTime('dd/mm/yyyy', Dados.FieldByName('RDZ_DTAMOV').AsDateTime) );
    Escrever(ProximaLinha, 01, 'NRO. REDUÇÃO: ' + Dados.FieldByName('RDZ_QTDRDZ').AsString);
    Escrever(LinhaAtual, 02, 'VALOR BRUTO: ' + FloatToStrF(Dados.FieldByName('RDZ_VALDIA').AsFloat, ffNumber, 12, 2));
    Escrever(LinhaAtual, 03, 'DESCONTO: ' + FloatToStrF(Dados.FieldByName('RDZ_TOTDSC').AsFloat, ffNumber, 12, 2));
    Escrever(ProximaLinha, 01, 'CANCELAMENTO: ' + FloatToStrF(Dados.FieldByName('RDZ_TOTCNL').AsFloat, ffNumber, 12, 2));
    Escrever(LinhaAtual, 02, 'VALOR CONTÁBIL: ' + FloatToStrF(Dados.FieldByName('RDZ_TOTCTB').AsFloat, ffNumber, 12, 2));
  End;
end;

procedure TfrmRelFiscMapaResumo.chkLayoutCat55Click(Sender: TObject);
begin
  inherited;
  If chkLayoutCat55.Checked Then
  Begin
    If Pos(edtDestino.Text, 'VI') <= 0 Then
      edtDestino.Text := 'V';

    blnExcel := False;
    ColorLabel1.Visible := False;
    ColorLabel2.Visible := True;
    chkPreencheCabecalho.Visible := True;
    If chkPreencheCabecalho.Checked Then
    Begin
      rgMapaResumo.Visible := True;
      edtNumRel.Visible := True;
      Label4.Visible := True;
    End;
  End
  Else
  Begin
    blnExcel := True;
    ColorLabel1.Visible := True;
    ColorLabel2.Visible := False;
    chkPreencheCabecalho.Visible := False;
    rgMapaResumo.Visible := False;
    edtNumRel.Visible := False;
    Label4.Visible := False;
  End;
end;

procedure TfrmRelFiscMapaResumo.chkPreencheCabecalhoClick(Sender: TObject);
begin
  inherited;
  If chkPreencheCabecalho.Checked Then
  Begin
    rgMapaResumo.Visible := True;
    Label4.Visible := True;
    edtNumRel.Visible := True;
  End
  Else
  Begin
    rgMapaResumo.Visible := False;
    Label4.Visible := False;
    edtNumRel.Visible := False;
  End;
end;

procedure TfrmRelFiscMapaResumo.edtCodEcfExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEcf, edtDesEcf, arrCadEcf, fRetModEcf , Nil, 'da Impressora Fiscal');
end;

procedure TfrmRelFiscMapaResumo.edtCodEcfKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqECF(Self, edtCodEcf, edtDesEcf, nil, Key, arrCadEcf, False) Then
    Begin
      If fValidaCampos(edtCodEcf, False) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelFiscMapaResumo.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscMapaResumo.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  if Assigned(QryRelatorio) then
    FreeAndNil(QryRelatorio);
end;

procedure TfrmRelFiscMapaResumo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);

  blnExcel             := True;
  QryRelatorio         := fCriaQuery;
  frxRelatorio.DataSet := QryRelatorio;

  ColorLabel1.Visible := True;
  ColorLabel2.Visible := False;

  cdsNovoMapaResumo.CreateDataSet;
end;

function TfrmRelFiscMapaResumo.fRetornaIESformatada(strIES, strEstado: String): string;
  Var
    strMask: string;
begin
  strIES := fTiraCaracEspeciais(strIES,True,True);

  Result := '';

  if fEmptyStr(strEstado) then
  begin
    ShowMessage('Não foi informado o estado da Inscrição !');
    Result := '';
    Exit;
  end;

  if strEstado = 'AC' then
  begin
    strMask := '999.99999.999-99;0;_';
  end
  else if strEstado = 'AL' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'AM' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'AP' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'BA' then
  begin
    strMask := '999999-99;0;_';
  end
  else if strEstado = 'CE' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'DF' then
  begin
    strMask := '999.99999.999-99;0;_';
  end
  else if strEstado = 'ES' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'GO' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'MA' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MT' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MS' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MG' then
  begin
    strMask := '999.999.999/9999;0;_';
  end
  else if strEstado = 'PA' then
  begin
    strMask := '99-999999-9;0;_';
  end
  else if strEstado = 'PB' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'PE' then
  begin
    // VALIDAÇÃO DA INSCRICAO ESTADUAL ANTIGA - 14 dígitos
    if length(strIES) > 9 then
    begin
      strMask := '99.9.999.9999999-9;0;_';
    end
    else
    // VALIDAÇÃO DA INSCRICAO ESTADUAL NOVA - 9 dígitos
    begin
      strMask := '9999999-99;0;_';
    end;
  end
  else if strEstado = 'PI' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'PR' then
  begin
    strMask := '999.99999-99;0;_';
  end
  else if strEstado = 'RJ' then
  begin
    strMask := '99.999.99-9;0;_';
  end
  else if strEstado = 'RN' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'RO' then
  begin
    strMask := '9999999999999-9;0;_';
  end
  else if strEstado = 'RR' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'RS' then
  begin
    strMask := '999/999999-9;0;_';
  end
  else if strEstado = 'SC' then
  begin
    strMask := '999.999.999;0;_';
  end
  else if strEstado = 'SE' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'SP' then
  begin
    if LeftStr(strIES, 1) = 'P' then
    begin
      strMask := 'P-99999999.9/999;0;_';
    end
    else
    begin
      strMask := '999.999.999.999;0;_';
    end;
  end
  else if strEstado = 'TO' then
  begin
    strMask := '99 999999 9;0;_';
  end;

  Result := FormatMaskText(strMask,strIES);
end;

function TfrmRelFiscMapaResumo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    strModelo: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEcf) Then
    Begin
      If Not fEmptyStr(edtCodEcf.Text) And (edtCodEcf.Text <> '00000') Then
      Begin
        If Not fValidaEcf(edtCodEcf.Text, strModelo) Then
        Begin
          fMensagem('ATENÇÃO', 'Impressora fiscal não cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesEcf.Text := strModelo;
        End;
      End;
    End;
  End;
end;

end.
