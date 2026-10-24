unit untRelChqPredatados;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, Uni,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  AppEvnts, BitBtnLockedIncrem, untFuncoesFactory, frxExportCSVTestabilidade,
  untIFuncoes, ComboBoxFocus, untMskC_G_C_;

type
  TfrmRelChqPredatados = class(TfrmPaiRelatorio)
    gpbCheques: TGroupBox;
    edtCheques: TEditFocus;
    ColorLabel2: TColorLabel;
    GroupBox1: TGroupBox;
    edtLocChq: TEditFocus;
    ColorLabel3: TColorLabel;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    lblPortad: TLabel;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    gpbTelecheque: TGroupBox;
    ColorLabel4: TColorLabel;
    edtTelecheque: TEditFocus;
    Label2: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    gpb1: TGroupBox;
    ColorLabel5: TColorLabel;
    grbDataCadastro: TGroupBox;
    mskCadIni: TMaskEditFocus;
    Label3: TLabel;
    Label6: TLabel;
    mskCadFin: TMaskEditFocus;
    grbDataVencimento: TGroupBox;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblPorChq: TLabel;
    edtPorChq: TEditFocus;
    edtDesPorChq: TEditFocus;
    cmbQuebra: TComboBoxFocus;
    Label4: TLabel;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    edtNomEmit: TEditFocus;
    Label5: TLabel;
    mskCnpjCpf: TMaskEditC_G_C_;
    edtValidaCnpjCpf: TEditFocus;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);

    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure pCarregaPortador(Var qryCadPor: TUniQuery);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodDigExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtPorChqKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
  private
    strLocChqAnt: String;
    strPeriodo: String;

    arrEmp,
    arrClientes,
    arrPorChq,
    arrPortador,
    arrOperador,
    arrFornec,
    arrCidade,
    arrEmi: TConsultasArray;

    strEmp      : String;
    strClientes : String;
    strPortador : String;
    strOperador : String;
    strPorChq   : String;
    strFornec   : String;
    strCidade   : String;
    strCGC      : String;
    strNomEmi, strEndere, strTele01 :String;
    intNumChq, intNumChqTot: Integer;

    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;

    procedure pHabilitaPortFornec(blnHabili: Boolean);
    procedure pGeraExcel;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelChqPredatados: TfrmRelChqPredatados;

implementation

uses untQckChqPredatados, Data.DB, untFuncoesGenerica, untExcel, untClassPanelcx;

{$R *.dfm}

procedure TfrmRelChqPredatados.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskCadIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskCadFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  inherited;
  pHabilitaPortFornec(False);
  strLocChqAnt := edtLocChq.Text;

  shpMultSel.Visible := True;
end;

procedure TfrmRelChqPredatados.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  {***********************************}
  {* VERIFICACAO DAS DATAS, PELO     *}
  {* MENOS UMA DEVE SER ESCOLHIDA    *}
  {** 08/04/2015 ******************MO*}
  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Or
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) Then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    Exit;
  End;

  pnlInfo.Caption := 'Aguarde... Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  Q.CHQ_CODBCO, ';
    strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
    strSQL := strSQL + '  Q.CHQ_CONCOR, ';
    strSQL := strSQL + '  Q.CHQ_NUMCHQ, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.CHQ_CODCLI, ';
    strSQL := strSQL + '  Q.CHQ_NOMEMI, ';
    strSQL := strSQL + '  Q.CHQ_TELEMI, ';
    strSQL := strSQL + '  Q.CHQ_NUMNOT, ';
    strSQL := strSQL + '  Q.CHQ_DTACAD, ';
    strSQL := strSQL + '  Q.CHQ_DTAVEN, ';
    strSQL := strSQL + '  Q.CHQ_DTAREP, ';
    strSQL := strSQL + '  Q.CHQ_DTACUS, ';
    strSQL := strSQL + '  Q.CHQ_VALCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CODOPE, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  Q.CHQ_C_G_C_  ' ;
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q ';
    strSQL := strSQL + '  JOIN CADCLI C ON CHQ_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  LEFT OUTER JOIN CHQTEL T ON T.CHQ_SEQCHQ = Q.AUTOINCREM ';
    strSQL := strSQL + 'WHERE TRUE ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
       Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      strSQL := strSQL + '  AND CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) And
       Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
      strSQL := strSQL + '  AND CHQ_DTACAD BETWEEN :CADINI AND :CADFIN ';

    If (edtLocChq.Text <> 'E') Then
      strSQL := strSQL + '  AND IFNULL(CHQ_INCCTR, '+QuotedStr('N')+') =   '+ QuotedStr('N');
    {******************************************}
    {* CONSULTA  POR CPFQ / CNPJ DE TERCEIROS *}
    {***************************LE*************}
    If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) then
      strSQL := strSQL + ' AND Q.CHQ_C_G_C_ = :CADEMI_C_G_C_  ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'Q.CHQ_CODCLI', 'CODCLI');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'Q.CHQ_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(Q.CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If (Not fEmptyStr(edtCodDig.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodDig, arrOperador, 'Q.CHQ_CODOPE', 'CODOPE');

    If (edtCheques.Text = 'E') Then
    Begin
      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (Q.CHQ_DTADEP IS NULL AND Q.CHQ_DTADV2 IS NULL) OR ';
      strSQL := strSQL + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADP2 IS NULL AND Q.CHQ_DTADV2 IS NULL) ';
      strSQL := strSQL + '      ) ';
    End

    Else If (edtCheques.Text = 'D') Then
    Begin
      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NULL) OR ';
      strSQL := strSQL + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADP2 IS NOT NULL AND Q.CHQ_DTADV2 IS NULL) OR ';
      strSQL := strSQL + '      (Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADV2 IS NOT NULL) ';
      strSQL := strSQL + ' ) ';
    End;

    If (edtLocChq.Text = 'C') Then
      strSQL := strSQL + '  AND CHQ_DTACUS IS NOT NULL '
    Else If (edtLocChq.Text = 'R') Then
      strSQL := strSQL + '  AND CHQ_DTAREP IS NOT NULL '
    Else If (edtLocChq.Text = 'N') Then
      strSQL := strSQL + '  AND (CHQ_DTAREP IS NULL AND CHQ_DTACUS IS NULL) '
    Else If (edtLocChq.Text = 'E') Then
      strSQL := strSQL + '  AND CHQ_DTAENV IS NOT NULL ';

    If Not fEmptyStr(edtPorChq.Text) Then
      strSQL := strSQL + fStrLocate(edtPorChq, arrPorChq, 'CHQ_PORCHQ', 'PORCHQ')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCUS, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORDEB, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCHQ, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    {***********************************}
    {* FILTRA PELO PORTADOR/FORNECEDOR *}
    {********************************PZ*}
    If (Not fEmptyStr(edtCodPor.Text)) Then
    Begin
      If (edtLocChq.Text = 'C') Then
      Begin
        If Not fEmptyStr(edtCodPor.Text) Then
          strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CHQ_PORCUS', 'CODPOR')
        Else
          strSQL := strSQL + '  AND LOCATE(CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';
      End
      Else If (edtLocChq.Text = 'R') Then
        strSQL := strSQL + fStrLocate(edtCodPor, arrFornec, 'CHQ_FORREP', 'CODPOR');
    End;

    {******************************}
    {* CONSULTA TELECHEQUE        *}
    {***************************RV*}
    If (edtTelecheque.Text = 'S') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = "S" '
    Else If (edtTelecheque.Text = 'N') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = "N" ';

    {*******************}
    {* PRAÇA DO CHEQUE *}
    {*REQ.35441******JU*}
    If (Not fEmptyStr(edtCodCid.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodCid, arrCidade, 'Q.CHQ_CODCID', 'CODCID');

    strSQL := strSQL + ' ORDER BY ';

    Case cmbQuebra.ItemIndex of
      0: strSQL := strSQL + '  CHQ_DTAVEN, CHQ_NUMCHQ ';
      1: strSQL := strSQL + '  CHQ_DTACAD, CHQ_NUMCHQ ';
      2: strSQL := strSQL + '  CHQ_NOMEMI, CHQ_DTAVEN, CHQ_NUMCHQ ';
      3: strSQL := strSQL + '  CHQ_NOMEMI, CHQ_DTACAD, CHQ_NUMCHQ ';
      4: strSQL := strSQL + '  CHQ_DTAVEN, CHQ_NOMEMI, CHQ_NUMCHQ ';
      5: strSQL := strSQL + '  CHQ_DTACAD, CHQ_NOMEMI, CHQ_NUMCHQ ';
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
         Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) And
         Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
      Begin
        ParamByName('CADINI').AsDate := StrToDate(mskCadIni.Text);
        ParamByName('CADFIN').AsDate := StrToDate(mskCadFin.Text);
      End;

      If Not fEmptyStr(edtCodCliente.Text) Then
        pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', qryRelatorio);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

      If (Not fEmptyStr(edtCodDig.Text)) Then
        pSetaParam(edtCodDig.Text, arrOperador, strOperador, 'CODOPE', qryRelatorio);

      If Not fEmptyStr(edtPorChq.Text) Then
        pSetaParam(edtPorChq.Text, arrPorChq, strPorChq, 'PORCHQ', qryRelatorio);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCPf.Text)) then
        pSetaParam(mskCnpjCpf.Text,arrEmi,strCgc,'CADEMI_C_G_C_',qryRelatorio);


      If (Pos(edtLocChq.Text, 'C_R_') > 0) And (Not fEmptyStr(edtCodPor.Text)) Then
      Begin

        If edtLocChq.Text = 'C' Then
        Begin
          If Not fEmptyStr(edtCodPor.Text) Then
            pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);
        End
        Else
          pSetaParam(edtCodPor.Text, arrFornec, strFornec, 'CODPOR', qryRelatorio);

      End;

      If (Not fEmptyStr(edtCodCid.Text)) Then
        pSetaParam(edtCodCid.Text, arrCidade, strCidade, 'CODCID', qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        If edtDestino.Text = 'E' Then
        begin
          pGeraExcel;
          pnlInfo.Caption := '';
        end
        Else
        Begin
          pCriarFormularios(TfrmQckChqPredatados,frmQckChqPredatados);

          frmQckChqPredatados.dtsRelatorio.DataSet := qryRelatorio;

          frmQckChqPredatados.strQuebra := intToStr(cmbQuebra.ItemIndex); //cmbQuebra.Text;

          If strTipImp = 'M' Then
          Begin
            frmQckChqPredatados.qckPagina.DefaultFilter := rldFiltro;
          End
          Else
          Begin
            frmQckChqPredatados.qckPagina.DefaultFilter := Nil;
          end;

          If edtCheques.Text = 'T' Then
          Begin
            if strTipImp = 'M' then
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATORIO DE CHEQUES - TODOS ';
            End
            Else
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATÓRIO DE CHEQUES - TODOS ';
            End;
          End
          Else
          If edtCheques.Text = 'E' Then
          Begin
            if strTipImp = 'M' then
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATORIO DE CHEQUES - NAO BAIXADOS '
            End
            Else
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATÓRIO DE CHEQUES - NÃO BAIXADOS ';
            End;
          End
          Else
          If edtCheques.Text = 'D' Then
          Begin
            if strTipImp = 'M' then
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATORIO DE CHEQUES - BAIXADOS ';
            End
            Else
            Begin
              frmQckChqPredatados.rllNomeRelatorio.Caption := 'RELATÓRIO DE CHEQUES - BAIXADOS ';
            End;
          End;

          If fEmptyStr(edtCodEmpresa.Text) Then
          Begin
            frmQckChqPredatados.rllEmpresa.Caption := 'EMPRESA: TODAS ';
          End
          Else
          Begin
            frmQckChqPredatados.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
          End;

          frmQckChqPredatados.rllDigita.Caption := fStrTitulo(edtCodDig.Text, edtNomDig, arrOperador, strOperador, 'DIGITADOR');

          frmQckChqPredatados.rllPorChq.Caption := fStrTitulo(edtPorChq.Text, edtDesPorChq, arrPorChq, strPorChq, 'PORTADOR DO CHEQUE');

          If (edtCodPor.Enabled) Then
          Begin
            frmQckChqPredatados.rllPortad.Visible := True;

            If (edtLocChq.Text = 'C') Then
            Begin
              If (fEmptyStr(edtCodPor.Text)) Then
                frmQckChqPredatados.rllPortad.Caption := 'PORTADOR: TODOS'
              Else
                frmQckChqPredatados.rllPortad.Caption := fStrTitulo(edtCodPor.Text, edtNomPor, arrPortador, strPortador, 'PORTADOR');
            End
            Else
            If (edtLocChq.Text = 'R') Then
            Begin
              If (fEmptyStr(edtCodPor.Text)) Then
                frmQckChqPredatados.rllPortad.Caption := 'FORNECEDOR: TODOS'
              Else
                frmQckChqPredatados.rllPortad.Caption := fStrTitulo(edtCodPor.Text, edtNomPor, arrFornec, strFornec, 'FORNECEDOR');
            End;
          End
          Else
          Begin
            frmQckChqPredatados.rllPortad.Visible   := False;
            //frmQckChqPredatados.rllOrdem.Top        := frmQckChqPredatados.rllPortad.Top;
            //frmQckChqPredatados.rlbCabecalho.Height := frmQckChqPredatados.rlbCabecalho.Height - frmQckChqPredatados.rllPortad.Height;
          End;

          If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) And
             Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
          Begin
             If strTipImp = 'M' then
             Begin
               strPeriodo := 'REFERENTE AO PERIODO (CADASTRO) DE ' + mskCadIni.Text + ' E ' + mskCadFin.Text;
             End
             Else
             Begin
               strPeriodo := 'REFERENTE AO PERÍODO (CADASTRO) DE ' + mskCadIni.Text + ' E ' + mskCadFin.Text;
             End;
          End
          Else
          Begin
            strPeriodo := '';
          End;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
             Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            if strTipImp = 'M' then
            Begin
              strPeriodo := strPeriodo + '  REFERENTE AO PERIODO (VENCIMENTO) DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
            End
            Else
            Begin
              strPeriodo := strPeriodo + '  REFERENTE AO PERÍODO (VENCIMENTO) DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
            End;
          End;

          frmQckChqPredatados.rllCadastro.Caption := strPeriodo;

          If fEmptyStr(edtCodCliente.Text) then
            frmQckChqpredatados.rllCliente.Caption := 'CLIENTE: TODOS'
          Else
            frmQckChqPredatados.rllCliente.Caption := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE');

          if edtLocChq.Text = 'C' then
          Begin
            frmQckChqPredatados.rllLocChq.Caption := 'LOCALIZAÇÃO DOS CHEQUES: CUSTÓDIA';
          End
          Else
          if edtLocChq.Text = 'R' then
          Begin
            frmQckChqPredatados.rllLocChq.Caption := 'LOCALIZAÇÃO DOS CHEQUES: REPASSE';
          End
          Else
          if edtLocChq.Text = 'N' then
          Begin
            frmQckChqPredatados.rllLocChq.Caption := 'LOCALIZAÇÃO DOS CHEQUES: NORMAL';
          End
          Else
          if edtLocChq.Text = 'T' then
          Begin
            frmQckChqPredatados.rllLocChq.Caption := 'LOCALIZAÇÃO DOS CHEQUES: TODOS';
          End
          Else
          if edtLocChq.Text = 'E' then
          Begin
            frmQckChqPredatados.rllLocChq.Caption := 'LOCALIZAÇÃO DOS CHEQUES: TELECHEQUE';
          End;

          If edtTelecheque.Text = 'T' then
          Begin
            frmQckChqPredatados.rllTeleChq.Caption := 'TELECHEQUE: TODOS';
          End
          Else
          If edtTelecheque.Text = 'S' then
          Begin
            frmQckChqPredatados.rllTeleChq.Caption := 'TELECHEQUE: SIM';
          End
          Else
          If edtTelecheque.Text = 'N' then
          Begin
            frmQckChqPredatados.rllTeleChq.Caption := 'TELECHEQUE: NÃO';
          End;

          If edtCheques.Text = 'T' then
          Begin
            frmQckChqPredatados.rllCheque.Caption := 'CHEQUES: TODOS';
          End
          Else
          if edtCheques.Text = 'E' then
          Begin
            frmQckChqPredatados.rllCheque.Caption := 'CHEQUES: EM ABERTO';
          End
          Else
          If edtCheques.Text = 'D' then
          Begin
            frmQckChqPredatados.rllCheque.Caption := 'CHEQUES: DEPOSITADOS';
          End;

          If fEmptyStr(edtCodCid.Text) Then
          Begin
            If strTipImp = 'M' Then
              frmQckChqpredatados.rllCodCid.Caption := 'PRACA: TODAS'
            Else
              frmQckChqpredatados.rllCodCid.Caption := 'PRAÇA: TODAS';
          End
          Else
          Begin
            If strTipImp = 'M' Then
              frmQckChqPredatados.rllCodCid.Caption := fStrTitulo(edtCodCid.Text, edtDesCid, arrCidade, strCidade, 'PRACA')
            Else
              frmQckChqPredatados.rllCodCid.Caption := fStrTitulo(edtCodCid.Text, edtDesCid, arrCidade, strCidade, 'PRAÇA');
          End;

          frmQckChqPredatados.RLLCnpjCpf.Caption := 'EMITENTE: '+edtNomEmit.Text;


          Case cmbQuebra.ItemIndex Of
            0 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE VENCIMENTO + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE VENCIMENTO + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_DTAVEN';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DTA CAD';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTACAD';
                End;

            1 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE CADASTRO + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE CADASTRO + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_DTACAD';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DT VENC';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTAVEN';
                End;

            2 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: EMITENTE + DATA DE VENCIMENTO + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: EMITENTE + DATA DE VENCIMENTO + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_NOMEMI';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DT VENC';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTAVEN';

                  frmQckChqPredatados.rllTotal.Caption     := 'TOTAL POR EMITENTE';
                  frmQckChqPredatados.rllRodDta.Visible    := False;
                End;

            3 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: EMITENTE + DATA DE CADASTRO + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: EMITENTE + DATA DE CADASTRO + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_NOMEMI';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DTA CAD';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTACAD';

                  frmQckChqPredatados.rllTotal.Caption     := 'TOTAL POR EMITENTE';
                  frmQckChqPredatados.rllRodDta.Visible    := False;
                End;

            4 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE VENCIMENTO + EMITENTE + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE VENCIMENTO + EMITENTE + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_DTAVEN';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DTA CAD';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTACAD';
                End;

            5 : Begin
                  if strTipImp = 'M' then
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE CADASTRO + EMITENTE + NUMERO DE CHEQUE';
                  End
                  Else
                  Begin
                    frmQckChqPredatados.rllAgrupa.Caption  := 'QUEBRA: DATA DE CADASTRO + EMITENTE + NÚMERO DE CHEQUE';
                  End;

                  frmQckChqPredatados.rlbGrupo.DataFields  := 'CHQ_DTACAD';
                  frmQckChqPredatados.lblDataCampo.Caption := 'DT VENC';
                  frmQckChqPredatados.rdbDtaVen.DataField  := 'CHQ_DTAVEN';
                End;
          End;

          If edtDestino.Text = 'V' Then
          Begin
            frmQckChqPredatados.qckPagina.PreviewModal;
          end
          Else
          Begin
            frmQckChqPredatados.qckPagina.Print;
          end;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckChqPredatados);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pSetFocus(mskCadIni);

  pnlInfo.Caption := '';
end;

function TfrmRelChqPredatados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}

    If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final de Vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de Vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de Vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data Inicial de Vencimento deve ser menor que a data final de Vencimento!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de Vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End
    {************************}
    {* VALIDA DATA CADASTRO *}
    {*********************RV*}
    Else
    If (Sender = mskCadFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And (StrToDateDef(mskCadFin.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de Cadastro deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de Cadastro deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskCadIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
          Begin
            If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
            Begin
              fMensagem('','A data Inicial de Cadastro deve ser menor que a data final de Cadastro!',['&O K']);
              Result := False;
              Sender := mskCadIni;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskCadIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) and (StrToDateDef(mskCadIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskCadIni;
      End;
    End
    {********************}
    {* VERIFICA CHEQUES *}
    {*****************ED*}
    Else If (Sender = edtCheques) Then
    Begin
      If edtCheques.Text = '' Then
      Begin
        fMensagem('ATENÇÃO!','O campo cheques deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (edtCheques.Text <> 'T') And
           (edtCheques.Text <> 'E') And
           (edtCheques.Text <> 'D') Then
        Begin
          fMensagem('ATENÇÃO!','O campo cheques deve ser T, E ou D!',['&O K']);
          Result := False;
        End
      End
    End
    Else
    If (Sender = edtLocChq) Then
    Begin
      If edtLocChq.Text = '' Then
      Begin

        fMensagem('ATENÇÃO!','O campo localização dos cheques deve ser preenchido!',['&O K']);
        Result := False;

      End
      Else
      Begin

        If (edtLocChq.Text <> 'C') And
           (edtLocChq.Text <> 'R') And
           (edtLocChq.Text <> 'N') And
           (edtLocChq.Text <> 'E') And
           (edtLocChq.Text <> 'T') Then
        Begin
          fMensagem('ATENÇÃO!','O campo localização dos cheques deve ser C, R, N, T ou E!',['&O K']);
          Result := False;
        End
        Else
        Begin
          If (edtLocChq.Text = 'R') Then
            lblPortad.Caption := 'Fornecedor (Somente para Repasse)'
          Else
          Begin
            lblPortad.Caption := 'Portador da Baixa (Somente para Custódia)';
            edtCodPor.Clear;
            edtNomPor.Clear;
          End;

          If (strLocChqAnt <> edtLocChq.Text) Then
          Begin
            edtCodPor.Clear;
            edtNomPor.Clear;
            strLocChqAnt := edtLocChq.Text;
          End;

          pHabilitaPortFornec(Pos(edtLocChq.Text,'C_R_') > 0);
        End;

      End;

    End
    Else
    If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pDesmarcaLista(edtCodEmpresa, arrEmp)
      Else
        edtDesEmpresa.Text := 'TODOS';

    End

    Else If (Sender = edtTelecheque) Then
    Begin
      If fEmptyStr(edtTelecheque.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo telecheque deve ser preenchido!', ['&O K']);
        Result := False;
      End
      Else Begin
        If (edtTelecheque.Text <> 'S') And
          (edtTelecheque.Text <> 'N') And
          (edtTelecheque.Text <> 'T') Then
       Begin
        fMensagem('ATENÇÃO!','O campo telecheque deve ser S, N ou T!',['&O K']);
        Result := False;
       End;
      End;

    End

    Else If Sender = edtPorChq Then
    Begin
      If fEmptyStr(edtPorChq.Text) Then
        edtDesPorChq.Text := 'TODOS'
      Else If (edtPorChq.Text <> '00000') Then
      Begin

        edtDesPorChq.Text := fRetNomPortador(edtPorChq.Text);

        If fEmptyStr(edtDesPorChq.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorChq.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End;
    End

    {******************************************}
    {* VALIDA O CÓDIGO DO PORTADOR/FORNECEDOR *}
    {***************************************PZ*}
    Else If (Sender = edtCodPor) And (edtCodPor.Enabled) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
        edtNomPor.Text := 'TODOS'
      Else If (edtPorChq.Text <> '00000') Then
      Begin

        If (edtLocChq.Text = 'R') Then
          pDesmarcaLista(edtCodPor, arrFornec)
        Else
        Begin
          edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

          If fEmptyStr(edtNomPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
              Result := False;
            End;
          End;
        End;

      End;

    End
    {***********************************}
    {* VALIDA O DIGITADOR              *}
    {********************************PZ*}
    Else If (Sender = edtCodDig) Then
    Begin

      If (fEmptyStr(edtCodDig.Text)) Then
        edtNomDig.Text := 'TODOS';

    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
        edtDesCliente.Text := 'TODOS';

    End

    {***********************************}
    {*  VALIDAÇÃP DESTINO              *}
    {********************************LE*}

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo destino deve ser preenchido!', ['&O K']);
        Result := False;
      End

      Else Begin
       If Pos(edtDestino.Text, 'V_I_E') <= 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'O campo destino deve ser V, I ou E!', ['&O K']);
         Result := False;
       End;
      End;
    End

     {***********************************}
    {*  RETORNA NOME POR  CPF OU CNPJ  *}
    {********************************LE*}
    Else if (Sender = edtValidaCnpjCpf) Then
    Begin
      If edtValidaCnpjCpf.Text = '' Then
      Begin
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
      End
      Else Begin
        If Pos(edtValidaCnpjCPf.Text,'1_2') <= 0  Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CNPJ/CPF deve ser 1 ou 2!', ['&OK']);
          Result := False;
        End
        Else Begin
          mskCnpjCpf.Enabled := True;
          If edtValidaCnpjCPf.Text = '1'  Then
            mskCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
          Else
            mskCnpjCPf.EditMask := fRetMascaraC_G_C_(fSetaPais,C_P_F_);
        End;
      End;
    End

    Else if (Sender = mskCnpjCpf) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
      Begin
        strCgc := fTiraCaracEspeciais(mskCnpjCpf.Text);
        If (Length(strCgc) < 14) AND (edtValidaCnpjCpf.Text = '1') OR   (Length(strCgc) < 11) OR
         (Length(strCgc) > 11) AND (edtValidaCnpjCpf.Text = '2') Then
        Begin
          fMensagem('ATENÇÃO', mskCnpjCpf.Text + ' não é um número de '+IfThen(edtValidaCnpjCpf.Text ='1','CNPJ','CPF')+' válido!', ['&Ok']);
          edtNomEmit.Text := 'TODOS';
          Result := False;
        End
        Else  Begin
        fRetDadosEmitente(mskCnpjCPf.Text, strNomEmi, strEndere, strTele01);
        If strNomEmi = '' Then
          edtNomEmit.Text := 'NÃO CADASTRADO'
        Else
         edtNomEmit.Text := strNomEmi;
        End;
      End
      Else Begin
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtValidaCnpjCpf.Text := '';
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelChqPredatados.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskCadIni);
end;

procedure TfrmRelChqPredatados.FormCreate(Sender: TObject);
begin
  inherited;

  blnExcel := True;

end;

procedure TfrmRelChqPredatados.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelChqPredatados.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqPredatados.edtCodCidExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCid, edtDesCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da cidade');

end;

procedure TfrmRelChqPredatados.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCidade(Self, edtCodCid, edtDesCid, Nil, Nil, Key, arrCidade, False) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqPredatados.edtCodDigExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDig, edtNomDig, arrOperador, fRetNomeOperador, Nil, 'do digitador');

end;

procedure TfrmRelChqPredatados.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodDig, edtNomDig, Nil, Key, arrOperador, False) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqPredatados.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente');

end;

procedure TfrmRelChqPredatados.pCarregaCliente(Var qryCadCli: TUniQuery);
begin

  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

end;

procedure TfrmRelChqPredatados.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelChqPredatados.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqPredatados.pCarregaPortador(Var qryCadPor: TUniQuery);
begin

  If Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If (edtLocChq.Text = 'C') Then
      edtNomPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString
    Else If (edtLocChq.Text = 'R') Then
      edtNomPor.Text := qryCadPor.FieldByName('FOR_NOMFOR').AsString;
  End
  Else
    edtCodPor.Text := '';

end;

procedure TfrmRelChqPredatados.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelChqPredatados.pGeraExcel;
  Var
    objExcel : TExcel;
    fltTotGer: Double;
    fltTotDia: Double;
    dtaDtaRef: String;
    dtaDtaDia: String;
    blnQuebra: Boolean;
begin

  {*******************************}
  {* CRIA O OBJETO DO TIPO EXCEL *}
  {****************************JU*}
  objExcel := TExcel.fCriarExcel(Self);

  {******************************************}
  {* ADICIONA UMA PASTA NA ÁREA DE TRABALHO *}
  {***************************************JU*}
  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';

    LinhaAtual := 01;

    {*************************************************}
    {* NOME DA EMPRESA, TÍTULO DO RELATÓRIO E FILTROS*}
    {**********************************************JU*}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    Escrever(ProximaLinha, 01, 'RELATÓRIO DE CHEQUES');
    ProximaLinha;

    If edtCodEmpresa.Text = '' Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA'));

    If edtCodDig.Text = '' Then
      Escrever(ProximaLinha, 01, 'DIGITADOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodDig.Text, edtNomDig, arrOperador, strOperador, 'DIGITADOR'));

    Escrever(ProximaLinha, 01,'EMITENTE: ' + edtNomEmit.Text);


    If edtCodCid.Text = '' then
      Escrever(ProximaLinha, 01, 'PRAÇA: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodCid.Text, edtDesCid, arrCidade, strCidade, 'PRAÇA'));

    if edtLocChq.Text = 'C' then
    Begin
      Escrever(ProximaLinha, 01, 'LOCALIZAÇÃO DOS CHEQUES: CUSTÓDIA');
    End
    Else
    if edtLocChq.Text = 'R' then
    Begin
      Escrever(ProximaLinha, 01, 'LOCALIZAÇÃO DOS CHEQUES: REPASSE');
    End
    Else
    if edtLocChq.Text = 'N' then
    Begin
      Escrever(ProximaLinha, 01, 'LOCALIZAÇÃO DOS CHEQUES: NORMAL');
    End
    Else
    if edtLocChq.Text = 'T' then
    Begin
      Escrever(ProximaLinha, 01, 'LOCALIZAÇÃO DOS CHEQUES: TODOS');
    End
    Else
    if edtLocChq.Text = 'E' then
    Begin
      Escrever(ProximaLinha, 01, 'LOCALIZAÇÃO DOS CHEQUES: TELECHEQUE');
    End;

    If edtTelecheque.Text = 'T' then
    Begin
      Escrever(ProximaLinha, 01, 'TELECHEQUE: TODOS');
    End
    Else
    If edtTelecheque.Text = 'S' then
    Begin
      Escrever(ProximaLinha, 01, 'TELECHEQUE: SIM');
    End
    Else
    If edtTelecheque.Text = 'N' then
    Begin
      Escrever(ProximaLinha, 01, 'TELECHEQUE: NÃO');
    End;

    If edtCheques.Text = 'T' then
    Begin
      Escrever(ProximaLinha, 01, 'CHEQUES: TODOS');
    End
    Else
    if edtCheques.Text = 'E' then
    Begin
      Escrever(ProximaLinha, 01, 'CHEQUES: EM ABERTO');
    End
    Else
    If edtCheques.Text = 'D' then
    Begin
      Escrever(ProximaLinha, 01, 'CHEQUES: DEPOSITADOS');
    End;

    Escrever(ProximaLinha, 01, fStrTitulo(edtPorChq.Text, edtDesPorChq, arrPorChq, strPorChq, 'PORTADOR DO CHEQUE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodPor.Text, edtNomPor, arrPortador, strPortador, 'PORTADOR DA BAIXA'));

    Case cmbQuebra.ItemIndex Of
      0: Escrever(ProximaLinha, 01, 'QUEBRA: DATA DE VENCIMENTO + NÚMERO CHEQUE');
      1: Escrever(ProximaLinha, 01, 'QUEBRA: DATA DE CADASTRO + NÚMERO CHEQUE');
      2: Escrever(ProximaLinha, 01, 'QUEBRA: EMITENTE + DATA VENCIMENTO + NÚMERO CHEQUE');
      3: Escrever(ProximaLinha, 01, 'QUEBRA: EMITENTE + DATA CADASTRO + NÚMERO CHEQUE');
      4: Escrever(ProximaLinha, 01, 'QUEBRA: DATA DE VENCIMENTO + EMITENTE + NÚMERO CHEQUE');
      5: Escrever(ProximaLinha, 01, 'QUEBRA: DATA DE CADASTRO + EMITENTE + NÚMERO CHEQUE');
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) And
       Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) Then
       strPeriodo := 'REFERENTE AO PERÍODO (CADASTRO) DE ' + mskCadIni.Text + ' E ' + mskCadFin.Text
    Else
    Begin
      strPeriodo := '';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
       Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
        strPeriodo := strPeriodo + '  REFERENTE AO PERÍODO (VENCIMENTO) DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
    End;

    Escrever(ProximaLinha, 01, strPeriodo);
    ProximaLinha;

    {*****************************************}
    {* MESCLA CÉLULAR PARA FORMATAR O TÍTULO *}
    {**************************************JU*}
    Mesclar('A1', 'N1');
    Mesclar('A2', 'N2');
    Mesclar('A3', 'N3');
    Mesclar('A4', 'N4');
    Mesclar('A5', 'N5');
    Mesclar('A6', 'N6');
    Mesclar('A7', 'N7');
    Mesclar('A8', 'N8');
    Mesclar('A9', 'N9');
    Mesclar('A10', 'N10');
    Mesclar('A11', 'N11');
    Mesclar('A12', 'N12');
    Mesclar('A13', 'N13');
    Mesclar('A14', 'N14');
    Mesclar('A15', 'N15');

    CorFundo('A2', 'N3', Cinza);
    CorFundo('A16', 'N16', Cinza);


    {***********}
    {* COLUNAS *}
    {********JU*}
    Escrever(LinhaAtual, 01, 'BANCO');
    Escrever(LinhaAtual, 02, 'AGENCIA');
    Escrever(LinhaAtual, 03, 'CTA. CORRENTE');
    Escrever(LinhaAtual, 04, 'NR. CHEQUE');
    Escrever(LinhaAtual, 05, 'NR. TEL.');
    Escrever(LinhaAtual, 06, 'LOC. CHEQUE');
    Escrever(LinhaAtual, 07, 'EMP.');
    Escrever(LinhaAtual, 08, 'CLIENTE');
    Escrever(LinhaAtual, 09, 'DIG.');
    Escrever(LinhaAtual, 10, 'EMITENTE');
    Escrever(LinhaAtual, 11, 'FONE');
    Escrever(LinhaAtual, 12, 'NR. NF');

    If (cmbQuebra.ItemIndex in [0, 4]) then
    begin
      Escrever(LinhaAtual, 13, 'DTA. CAD.');
    end
    else if (cmbQuebra.ItemIndex in [1, 5]) then
    begin
      Escrever(LinhaAtual, 13, 'DTA. VEN.');
    end
    else if (cmbQuebra.ItemIndex = 2) then
    begin
      Escrever(LinhaAtual, 13, 'DTA. VEN.');
    end
    Else
    Begin
      Escrever(LinhaAtual, 13, 'DTA. CAD.');
    End;

    Escrever(LinhaAtual, 14, 'VALOR');

    {**************************************}
    {* COLOCA EM NEGRITO TÍTULO E COLUNAS *}
    {***********************************JU*}
    Negrito('A1', 'N16', True);

    {*****************}
    {* COLOCA BORDAS *}
    {**************JU*}
    Bordas('A2', 'N3');
    Bordas('A4', 'N16');

    Alinhamento('A1', 'N15', Centro);

    ProximaLinha;

    blnQuebra := False;
    With qryRelatorio Do
    Begin
      First;
      fltTotGer := 0;
      While Not Eof Do
      Begin
        fltTotDia := 0;

        If (cmbQuebra.ItemIndex in [0, 4]) then
        begin
          dtaDtaRef := FieldByName('CHQ_DTACAD').AsString;
          dtaDtaDia := FieldByName('CHQ_DTAVEN').AsString;
        end
        else if (cmbQuebra.ItemIndex in [1, 5]) then
        begin
          dtaDtaRef := FieldByName('CHQ_DTAVEN').AsString;
          dtaDtaDia := FieldByName('CHQ_DTACAD').AsString;
        end
        else if (cmbQuebra.ItemIndex in [2, 3]) then
        begin
          dtaDtaRef := FieldByName('CHQ_NOMEMI').AsString;
        end;

        While (not blnQuebra) And Not (Eof) Do
        Begin

          Escrever(LinhaAtual, 01, '''' + FieldByName('CHQ_CODBCO').AsString);
          Escrever(LinhaAtual, 02, '''' + FieldByName('CHQ_NUMAGE').AsString);
          Escrever(LinhaAtual, 03, '''' + FieldByName('CHQ_CONCOR').AsString);
          Escrever(LinhaAtual, 04, '''' + FieldByName('CHQ_NUMCHQ').AsString);
          Escrever(LinhaAtual, 05, '''' + FieldByName('CHQ_TELNUM').AsString);

          If Not FieldByName('CHQ_DTAREP').IsNull Then
            Escrever(LinhaAtual, 06, 'REPASSE')
          Else If Not FieldByName('CHQ_DTACUS').IsNull Then
            Escrever(LinhaAtual, 06, 'CUSTODIA')
          Else If (FieldByName('CHQ_DTAREP').IsNull) And (FieldByName('CHQ_DTACUS').IsNull) Then
            Escrever(LinhaAtual, 06, 'NORMAL');

          Escrever(LinhaAtual, 07, '''' + FieldByName('CHQ_CODEMP').AsString);
          Escrever(LinhaAtual, 08, '''' + FieldByName('CHQ_CODCLI').AsString + '-' + FieldByName('CLI_NOMCLI').AsString);
          Escrever(LinhaAtual, 09, '''' + FieldByName('CHQ_CODOPE').AsString);
          Escrever(LinhaAtual, 10, '''' + FieldByName('CHQ_NOMEMI').AsString);
          Escrever(LinhaAtual, 11, '''' + fFormataFone(FieldByName('CHQ_TELEMI').AsString));
          Escrever(LinhaAtual, 12, '''' + FieldByName('CHQ_NUMNOT').AsString);

          If (cmbQuebra.ItemIndex in [0, 4]) then
          begin
            Escrever(LinhaAtual, 13, '''' + FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTACAD').AsDateTime));
          end
          else if (cmbQuebra.ItemIndex in [1, 5]) then
          begin
            Escrever(LinhaAtual, 13, '''' + FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAVEN').AsDateTime));
          end
          else if (cmbQuebra.ItemIndex = 2) then
          Begin
            Escrever(LinhaAtual, 13, '''' + FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAVEN').AsDateTime));
          End
          Else
          Begin
            Escrever(LinhaAtual, 13, '''' + FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTACAD').AsDateTime));
          End;

          Escrever(LinhaAtual, 14, FloatToStrF(FieldByName('CHQ_VALCHQ').AsFloat, ffFixed, 12, 2));

          Alinhamento(LinhaAtual, 14, Direita);

          fltTotDia := fltTotDia + FieldByName('CHQ_VALCHQ').AsFloat;
          fltTotGer := fltTotGer + FieldByName('CHQ_VALCHQ').AsFloat;

          inc(intNumChq);
          inc(intNumChqTot);

          ProximaLinha;
          Next;

          If (cmbQuebra.ItemIndex in [0, 4]) then
          begin
            blnQuebra := FieldByName('CHQ_DTAVEN').AsString <> dtaDtaDia;
          end
          else if (cmbQuebra.ItemIndex in [1, 5]) then
          begin
            blnQuebra := FieldByName('CHQ_DTACAD').AsString <> dtaDtaDia;
          end
          else if (cmbQuebra.ItemIndex in [2, 3]) then
          begin
            blnQuebra := FieldByName('CHQ_NOMEMI').AsString <> dtaDtaRef;
          end;
        End;

        If (blnQuebra) Or (Eof) Then
        Begin
          blnQuebra := False;

          if cmbQuebra.ItemIndex in [2, 3] then
          Begin
            Escrever(LinhaAtual, 1, 'TOTAL:');
          End
          Else
          Begin
            Escrever(LinhaAtual, 1, 'TOTAL DO DIA:');
            Escrever(LinhaAtual, 2, dtaDtaDia);
          End;

          Escrever(LinhaAtual, 13, IntToStr(intNumChq) + ' Cheque(s)');
          intNumChq := 0;
          Escrever(LinhaAtual, 14, FloatToStrF(fltTotDia, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, 14, Direita);
          Mesclar('B' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual));
          Negrito('A' + IntToStr(LinhaAtual), 'N' + IntToStr(LinhaAtual), True);
          Bordas('A' + IntToStr(LinhaAtual), 'N' + IntToStr(LinhaAtual));

          ProximaLinha;
        End;

      End;

      Escrever(LinhaAtual, 13, IntToStr(intNumChqTot) + ' Cheque(s)');
      intNumChqTot := 0;
      Escrever(LinhaAtual, 1, 'TOTAL GERAL:');
      Escrever(LinhaAtual, 14, FloatToStrF(fltTotGer, ffFixed, 12, 2));
      Alinhamento(LinhaAtual, 14, Direita);
      Mesclar('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual));
      Negrito('A' + IntToStr(LinhaAtual), 'N' + IntToStr(LinhaAtual), True);
      Bordas('A' + IntToStr(LinhaAtual), 'N' + IntToStr(LinhaAtual));
    End;

    CongelarPaines('A17');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;
    pnlInfo.Caption := '';

    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
  End;

  FreeAndNil(objExcel);
end;

procedure TfrmRelChqPredatados.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If edtLocChq.Text = 'R' Then
    pEdtCodSelectExit(edtCodPor, edtNomPor, arrFornec, fRetNomFornecedor, Nil, 'do fornecedor');

end;

procedure TfrmRelChqPredatados.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If edtLocChq.Text = 'C' Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrPortador, False) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End
  Else If edtLocChq.Text = 'R' Then
  Begin
    If fPesqFornecedor(conForSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrFornec, False) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmRelChqPredatados.edtPorChqKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqPortador(conSimples, Self, edtPorChq, edtDesPorChq, nil, Key, arrPorChq, False) Then
  Begin
    If fValidaCampos(edtPorChq, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelChqPredatados.pHabilitaPortFornec(blnHabili: Boolean);
begin
  edtCodPor.Enabled := blnHabili;

  If (blnHabili) Then
  Begin
    If (edtLocChq.Text = 'C') Then
    Begin
      edtCodPor.MaxLength := 5;
      edtCodPor.TamCampo  := 5;
    End
    Else If (edtLocChq.Text = 'R') Then
    Begin
      edtCodPor.MaxLength := 8;
      edtCodPor.TamCampo  := 8;
    End
  End;

end;

end.

