unit untFatBaixaEmprestimos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untFuncFat, StrUtils, MaskUtils, BitBtnLockedIncrem,
  ComCtrls, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, cxProgressBar, untLiberacao, untTLock,
  untAuditoriaGravacaoSaldo;

type
  TfrmFatBaixaEmprestimos = class(TfrmPaiOrdena)
    btnBaiEmp: TBitBtnLocked;
    btnGerPed: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    rdgTipEmp: TRadioGroup;
    cdsConsultaTOTDOC: TAggregateField;
    lblInformacao: TLabel;
    pbProgresso: TProgressBar;
    btnGerCTP: TBitBtnLocked;
    procedure btnMarDesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure rdgTipEmpEnter(Sender: TObject);
    procedure rdgTipEmpClick(Sender: TObject);
    procedure btnBaiEmpClick(Sender: TObject);
    procedure btnGerPedClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerCTPClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryCadCli : TUniQuery;
    intQtdEPS : Integer; //Quantidade de emprestimos selecionados
    intDecQtd : Integer;
    intDecUni : Integer;
    blnZerTax : Boolean;
    blnManPre : Boolean;
    blnTabPreAtual: Boolean;
    blnBaixaCTPAVista : boolean;
    LastKey   : Word;

    strNumDocBE : String;
    strVenFil   : String;
    strTabPreFF : String;
    strDocumentosSelecionados: string;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    fatVenda: TfatVenda;

    objLiberacao : TLiberacao;
    objLock: TLock;

    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    Procedure pCriaTemporariaFF(Var fatVenda : TFatVenda);
    procedure pCarregarCliente(fatVenda: TFatVenda);
    Procedure pImprimeBaixaEmprestimo;
    procedure pLimpaCamposPesquisaPai;

    procedure pRegistraProgresso(strInfo: String; intPos, intMax: Integer);

    function fPodeBaixarEmprestimo: Boolean;
    function fPodeGerarFF: Boolean;

    function fPedeTabelaPrecoFF: Boolean;

    Function fBaixaDetEmprestimo(strAutInc: String; fltQtdBai: Double): Boolean;
    Function fBaixaEmprestimo(strEntSai, strCodCli: String; blnConTra: Boolean = True; strCodVen: String = ''; blnMovimentaKardex: Boolean = True; blnGeraContasAPagar: boolean = False): Boolean;
    Function fBaixaEmprestimoFF: Boolean;
    function fDigitaDescontoEspecial: Boolean;

    Function fGeraFF(strCodCli: String; Var strNumDoc: String; Var strMsgErroAdicional: String; strCodVen: String = ''): Boolean;

    Function fChaveRegistro: String;
    Function fIncluiItens(fatVenda: TFatVenda): Boolean;
    Function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fTemTinta: Boolean;
    Function fGetCndPagto(fatVenda: TFatVenda;
                          blnHabZta: Boolean = True;
                          blnHabMPr: Boolean = False): Boolean;

    function fExecutarRecalculoPrecosCondPagto: Boolean;
    function fRecalculaPrecosCondPagto: Boolean;
    Function fQtdABaixarIncorreta: Boolean;
    procedure pProcessaItensTintaDeMaquina;
    procedure pLimpaConsulta(idxRdg:Integer=0);

    function fRetTotGer_e_MontaListaEmprestimos(strCodVen: String = ''): Double;

    function fTravaBaixa: Boolean;
    function fRetSaldoProduto(strCodIte, strNumLot, strCodAca, strEmpAca: String; blnProAca: Boolean; fltCnv_Ml, fltSal_Ml: Double): Double;
    function  fProcessaSaldoEstoqueProdutos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pProcessaSaldoEstoqueProdutos;

  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSQLVendedores: String;


  end;


implementation

uses  Math, untConsultas, untTypesSistema,
      untPai,
      untMovGer, untCadIte, untGravando, untDigCndPagamento,
      untFuncoesSimples, untPesqAux, untFuncFatTypes, untFuncoes,
      untFuncTinta, untFatDigTabPrecoBaixaEmprestimos, untFatDigDesconto,
      untDigDesconto, untProdAcabado, untDuplicatas, untGeraPagamentos, untCadPag,
      untTBanCtpRepository, untConstantes, untMovBan, Faturamento.Classes.TAlterarPedido,
      untTFatReservaSaldo, untIFatEntregaFutura, untTFatEntregaFutura,
  untFatSelecaoTabelaPreco, untFatImpressao;

{$R *.dfm}

procedure TfrmFatBaixaEmprestimos.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  If Not (fEmptyStr(edtCodCli.Text)) Then
    edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtNomCli.Text := '';
end;

function TfrmFatBaixaEmprestimos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := FALSE;
      End
      Else
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End
        Else
        begin
          if ( fTravaBaixa ) then
          begin
            fAbreConsulta(TRUE);
            pnlHeader.Enabled := False;
            pSetFocus(dbgConsulta);
          end
          else
            Result := True;

        end;
      End
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatBaixaEmprestimos.fGetSql(blnLike: Boolean): String;
  Var
    sqlSql: String;
Begin
  sqlSql := '';
  sqlSql := sqlSql + ' SELECT          ';
  sqlSql := sqlSql + '   D.DET_CODVEN, ';
  sqlSql := sqlSql + '   D.DET_CODVE2, ';
  sqlSql := sqlSql + '   D.DET_IDEPRO, ';
  sqlSql := sqlSql + '   D.DET_CODITE, ';
  sqlSql := sqlSql + '   D.DET_DESCRI, ';
  sqlSql := sqlSql + '   D.DET_UNIDAD, ';
  sqlSql := sqlSql + '   D.DET_CODMAR, ';
  sqlSql := sqlSql + '   D.DET_FORITE, ';
  sqlSql := sqlSql + '   D.DET_REFERE, ';
  sqlSql := sqlSql + '   D.DET_UNIORI, ';
  sqlSql := sqlSql + '   T.DET_UNIVIS, ';
  sqlSql := sqlSql + '   T.DET_VAL_RT, ';
  sqlSql := sqlSql + '   T.DET_TAXJUR, ';
  sqlSql := sqlSql + '   D.DET_UNITAR, ';
  sqlSql := sqlSql + '   D.DET_DESESP, ';
  sqlSql := sqlSql + '   D.DET_QTDITE, ';
  sqlSql := sqlSql + '   D.DET_DESCON, ';
  sqlSql := sqlSql + '   D.DET_TOTCUS, ';
  sqlSql := sqlSql + '   D.DET_TOTCU2, ';
  sqlSql := sqlSql + '   D.DET_INCPIS, ';
  sqlSql := sqlSql + '   D.DET_ITECHA, ';
  sqlSql := sqlSql + '   D.DET_ITEEMB, ';
  sqlSql := sqlSql + '   D.DET_ITETIN, ';
  sqlSql := sqlSql + '   D.DET_LINLIN, ';
  sqlSql := sqlSql + '   D.DET_DESCOR, ';
  sqlSql := sqlSql + '   D.DET_TIPPRE, ';
  sqlSql := sqlSql + '   D.DET_LAZQUA, ';
  sqlSql := sqlSql + '   D.DET_TIPEMB, ';
  sqlSql := sqlSql + '   D.DET_PRCTIN, ';
  sqlSql := sqlSql + '   D.DET_FATTIN, ';
  sqlSql := sqlSql + '   D.DET_PROMOC, ';
  sqlSql := sqlSql + '   D.DET_SEQTIN, ';
  sqlSql := sqlSql + '   D.DET_VOLPRO, ';
  sqlSql := sqlSql + '   D.DET_CODACA, ';
  sqlSql := sqlSql + '   D.DET_EMPACA, ';
  sqlSql := sqlSql + '   D.DET_PROACA, ';
  sqlSql := sqlSql + '   D.DET_ESPDOC, ';
  sqlSql := sqlSql + '   D.DET_NUMDOC, ';
  sqlSql := sqlSql + '   D.DET_CODEMP, ';
  sqlSql := sqlSql + '   D.DET_TABPRE, ';
  sqlSql := sqlSql + '   D.DET_CODDIL, ';
  sqlSql := sqlSql + '   D.DET_PORDIL, ';
  sqlSql := sqlSql + '   D.DET_PRVTIN, ';
  sqlSql := sqlSql + '   D.DET_NUMLOT, ';

  sqlSql := sqlSql + '   D.DET_CODEMP AS CODEMP, ';
  sqlSql := sqlSql + '   D.DET_DTAENT AS DTAENT, ';
  sqlSql := sqlSql + '   D.DET_NUMDOC AS NUMDOC, ';
  sqlSql := sqlSql + '   D.DET_ESPDOC AS ESPDOC, ';
  sqlSql := sqlSql + '   D.DET_CODITE AS CODITE, ';
  sqlSql := sqlSql + '   D.DET_IDEPRO AS IDEPRO, ';

  sqlSql := sqlSql + '   I.ITE_CODGRU AS CODGRU, ';
  sqlSql := sqlSql + '   DET_DESCRI AS DESITE, ';
  sqlSql := sqlSql + '   DET_REFERE AS REFERE, ';
  sqlSql := sqlSql + '   DET_UNIDAD AS CODUNI, ';
  sqlSql := sqlSql + '   D.DET_FORITE AS CODFOR, ';
  sqlSql := sqlSql + '   I.ITE_CODMAR AS CODMAR, ';
  sqlSql := sqlSql + '   I.ITE_INCPIS AS INCPIS, ';
  sqlSql := sqlSql + '   UNI_SIGUNI AS SIGUNI, ';
  sqlSql := sqlSql + '   D.DET_QTDITE AS QTDORI, ';
  sqlSql := sqlSql + '   (D.DET_QTDITE - IFNULL(D.DET_BAIEMP,0)) AS QTDITE, ';
  sqlSql := sqlSql + '   D.DET_UNITAR AS UNITAR, ';
  sqlSql := sqlSql + '   D.DET_UNIORI AS UNIORI, ';
  sqlSql := sqlSql + '   T.DET_UNIVIS AS UNIVIS, ';
  sqlSql := sqlSql + '   T.DET_VAL_RT AS VAL_RT, ';
  sqlSql := sqlSql + '   T.DET_TAXJUR AS TAXJUR, ';
  sqlSql := sqlSql + '   (D.DET_TOTITE/D.DET_QTDITE) * (D.DET_QTDITE - IFNULL(D.DET_BAIEMP,0)) AS TOTITE,  ';
  sqlSql := sqlSql + '   0.0000     AS QTDBAI, ';
  sqlSql := sqlSql + '   D.DET_IND_PD AS IND_PD, ';
  sqlSql := sqlSql + '   D.AUTOINCREM,         ';

  sqlSql := sqlSql + '   G.ITE_PRECUS AS PRECUS, ';
  sqlSql := sqlSql + '   G.ITE_ICMSAI AS ICMSAI, ';
  sqlSql := sqlSql + '   G.ITE_IMPFED AS IMPFED, ';
  sqlSql := sqlSql + '   G.ITE_DESOPE AS DESOPE, ';
  sqlSql := sqlSql + '   G.ITE_PREMED AS PREMED, ';
  sqlSql := sqlSql + '   G.ITE_SALDOS AS SALDOS, ';
  sqlSql := sqlSql + '   G.ITE_SALDOS AS SALDIS, ';
  sqlSql := sqlSql + '   G.ITE_SAL_ML, ';
  sqlSql := sqlSql + '   I.ITE_CNV_ML, ';

  sqlSql := sqlSql + '   M.ITE_PREVE1 AS DET_PREVE1, ';
  sqlSql := sqlSql + '   M.ITE_PREVE2 AS DET_PREVE2, ';
  sqlSql := sqlSql + '   M.ITE_PREVE3 AS DET_PREVE3, ';
  sqlSql := sqlSql + '   M.ITE_PREVE4 AS DET_PREVE4, ';
  sqlSql := sqlSql + '   M.ITE_PREVE5 AS DET_PREVE5, ';
  sqlSql := sqlSql + '   M.ITE_PREVE6 AS DET_PREVE6, ';
  sqlSql := sqlSql + '   M.ITE_PREVE7 AS DET_PREVE7  ';

  sqlSql := sqlSql + ' FROM          ';
  sqlSql := sqlSql + '   MOVDET D   ';
  sqlSql := sqlSql + '   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE     ';
  sqlSql := sqlSql + '    LEFT JOIN CADUNI   ON   UNI_CODUNI = DET_UNIDAD       ';
  sqlSql := sqlSql + '   INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE AND ';
  sqlSql := sqlSql + '                          G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  sqlSql := sqlSql + '   LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  sqlSql := sqlSql + '   LEFT JOIN MOVITE M ON M.ITE_SEQGER = D.AUTOINCREM ';
  sqlSql := sqlSql + '                     AND D.DET_IDEPRO = "NOR"        ';

  sqlSql := sqlSql + '   INNER JOIN ABFICM ON  ';

  If fCfgSIs('TIPABF') = '1' Then
    sqlSQL := sqlSql + '  I.ITE_CODABF = ABF_CODABF AND '
  Else
    sqlSQL := sqlSql + '  G.ITE_CODABF = ABF_CODABF AND ';

  sqlSql := sqlSql + '  ABF_ESTADO = :ESTADO ';

  sqlSql := sqlSql + ' WHERE  ';
  sqlSql := sqlSql + '   D.DET_CODEMP = :CODEMP AND ';
  sqlSql := sqlSql + '   D.DET_ESPDOC = "EP" AND ';
  sqlSql := sqlSql + '   D.DET_CODCLI = :CODCLI AND ';
  sqlSql := sqlSql + '   ROUND(D.DET_QTDITE, :DECQTD) - ROUND(IFNULL(D.DET_BAIEMP,0), :DECQTD) > 0 AND ';
  sqlSql := sqlSql + '   D.DET_PROEMB <> "S" AND ';

  If rdgTipEmp.ItemIndex = 0 Then
    sqlSql := sqlSql + '  LEFT(D.DET_CLAFIS, 1) <  "5" '
  Else
    sqlSql := sqlSql + '  LEFT(D.DET_CLAFIS, 1) >= "5" ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    sqlSql := sqlSql + ' AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  Result := sqlSql;
End;

function TfrmFatBaixaEmprestimos.fSetParametros: Boolean;
Begin
  With qryConsulta, Sql Do
  Begin
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    ParamByName('ESTADO').AsString  := fCadEmp('ESTADO');
    ParamByName('DECQTD').AsInteger := intDecQtd;

    If Not fEmptyDate(mskDtaIni.Text) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;
  End;

  Result := True;
End;

function TfrmFatBaixaEmprestimos.fSQLVendedores: String;
  Var
    sqlSql: String;
Begin
  sqlSql := '';
  sqlSql := sqlSql + ' SELECT DISTINCT ';
  sqlSql := sqlSql + '   D.DET_CODVEN  ';
  sqlSql := sqlSql + ' FROM            ';
  sqlSql := sqlSql + '   MOVDET D      ';
  sqlSql := sqlSql + '   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE     ';
  sqlSql := sqlSql + '    LEFT JOIN CADUNI   ON   UNI_CODUNI = DET_UNIDAD       ';
  sqlSql := sqlSql + '   INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE AND ';
  sqlSql := sqlSql + '                          G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  sqlSql := sqlSql + '   LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  sqlSql := sqlSql + '   INNER JOIN ABFICM ON  ';

  If fCfgSIs('TIPABF') = '1' Then
    sqlSQL := sqlSql + '  I.ITE_CODABF = ABF_CODABF AND '
  Else
    sqlSQL := sqlSql + '  G.ITE_CODABF = ABF_CODABF AND ';

  sqlSql := sqlSql + '  ABF_ESTADO = :ESTADO ';

  sqlSql := sqlSql + ' WHERE  ';
  sqlSql := sqlSql + '   D.DET_CODEMP = :CODEMP AND ';
  sqlSql := sqlSql + '   D.DET_ESPDOC = "EP" AND ';
  sqlSql := sqlSql + '   D.DET_CODCLI = :CODCLI AND ';
  sqlSql := sqlSql + '   ROUND(D.DET_QTDITE, :DECQTD) - ROUND(IFNULL(D.DET_BAIEMP,0), :DECQTD) > 0 AND ';
  sqlSql := sqlSql + '   D.DET_PROEMB <> "S" AND ';

  If rdgTipEmp.ItemIndex = 0 Then
    sqlSql := sqlSql + '  LEFT(D.DET_CLAFIS, 1) <  "5" '
  Else
    sqlSql := sqlSql + '  LEFT(D.DET_CLAFIS, 1) >= "5" ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    sqlSql := sqlSql + ' AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  Result := sqlSql;
end;

procedure TfrmFatBaixaEmprestimos.btnMarDesClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;



  With cdsConsulta Do
  Begin
    Edit;

    If Not fInLista Then
      FieldByName('QTDBAI').AsFloat := FieldByName('QTDITE').AsFloat
    Else
      FieldByName('QTDBAI').AsFloat := 0;

    Post;
  End;

end;

procedure TfrmFatBaixaEmprestimos.btnPesquisarClick(Sender: TObject);
begin
  If Not (cdsConsulta.IsEmpty) Then
    inherited;
end;

procedure TfrmFatBaixaEmprestimos.btnSairClick(Sender: TObject);
begin
  If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
  Begin
    pLimpaConsulta;
    Close;
  End;
end;

procedure TfrmFatBaixaEmprestimos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LastKey:=Key;

  Case Key Of
    VK_SPACE : If btnMarDes.Visible Then btnMarDes.Click;
    VK_F10   : If btnBaiEmp.Visible Then btnBaiEmp.Click;
    VK_F8    : Begin
                 If btnGerPed.Visible Then
                   btnGerPed.Click
                 else If btnGerCTP.Visible Then
                   btnGerCTP.Click;
               End;
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True)

               Else If cdsConsulta.State = dsEdit Then
               Begin
                 cdsConsulta.Post;
                 cdsConsulta.FieldByName('QTDBAI').FocusControl;
               End
               Else If cdsConsulta.Active And (Not SameText(dbgConsulta.SelectedField.FieldName,'QTDBAI')) Then
               Begin
                cdsConsulta.FieldByName('QTDBAI').FocusControl;
                cdsConsulta.Edit;
               End
               Else
                inherited;
    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else
               Begin
                 If cdsConsulta.Active And (cdsConsulta.RecordCount > 0) Then
                 Begin
                   If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
                   Begin
                     pLimpaConsulta;
                   End;
                 End
                 Else
                 begin
                   inherited;
                   pnlHeader.Enabled := True;
                 end;
               End;
    VK_UP,
    VK_DOWN:   If cdsConsulta.State = dsEdit Then
               Begin
                 Key:=0;
                 cdsConsulta.Post;
                 If cdsConsulta.FieldByName('QTDBAI').AsInteger <=0 Then
                   Key:=LastKey;
               End
               Else
                 inherited;
    Else
      inherited;
  End;

end;

procedure TfrmFatBaixaEmprestimos.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco  := FALSE;
  blnSelecionaComEnter := FALSE;
  blnQuoteLista        := FALSE;

  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDate;

  pSetFocus(rdgTipEmp.Controls[0] As TWinControl);

  pLimpaPesquisa;  
end;

procedure TfrmFatBaixaEmprestimos.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If FieldByName('QTDBAI').AsFloat > 0 Then
    Begin
      If Not fInLista Then
        pAddListaQuery; // Marca

      If LastKey = VK_UP Then
        Prior
      Else
        Next;

      LastKey:=0;
    End

    Else If fInLista Then
      pAddListaQuery; // Desmarca

  End;
end;

function TfrmFatBaixaEmprestimos.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := inherited fAbreConsulta(blnLike);

  If cdsConsulta.Active Then
    cdsConsulta.LogChanges := False;

  If fCfgSis('ESLDBE', VarBoolean) Then
    pProcessaSaldoEstoqueProdutos;

  If Result Then
  Begin
    (cdsConsulta.FieldByName('QTDBAI') As TFloatField).DisplayFormat := fMskDigitos(intDecQtd);
    (cdsConsulta.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(intDecQtd);
    (cdsConsulta.FieldByName('UNITAR') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);

    If fCfgSis('ESLDBE', VarBoolean) Then
      (cdsConsulta.FieldByName('SALDIS') As TFloatField).DisplayFormat := fMskDigitos(3);

    If (Not cdsConsulta.IsEmpty) Then
     cdsConsulta.FieldByName('QTDBAI').FocusControl;
  End;

End;

procedure TfrmFatBaixaEmprestimos.cdsConsultaBeforePost(DataSet: TDataSet);
  Var
    strInformacao: String;
begin
  inherited;

  With DataSet Do
  Begin
    If (RoundTo(FieldByName('QTDBAI').AsFloat, -intDecQtd) > 0) And
       (fCampoTabela('ITE_ITEATI', 'CADITE', ['ITE_CODITE'], [FieldByName('CODITE').AsString]) = 'N') Then
    Begin
      cdsConsulta.FieldByName('QTDBAI').FocusControl;
      fMensagem('ATENÇÃO!', 'O item ' + FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString + ' está inativo. Verifique o Cadastro do Produto!', ['&Ok']);
      Cancel;
      Abort;
    End;

    If RoundTo(FieldByName('QTDBAI').AsFloat, -intDecQtd) > RoundTo(FieldByName('QTDITE').AsFloat, -intDecQtd) Then
    Begin
      cdsConsulta.FieldByName('QTDBAI').FocusControl;
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('QTDBAI').AsFloat > 0) And
            (TFatVenda.fUltrapassouLimiteItensNFe(stlListSelecao.Count + 1, '', strInformacao)) Then
    Begin
      pMensagemSonora(strInformacao);
      cdsConsulta.FieldByName('QTDBAI').FocusControl;
      Cancel;
      Abort;
    End;
  End;

end;

procedure TfrmFatBaixaEmprestimos.dbgConsultaDblClick(Sender: TObject);
begin
//  inherited;
  If btnMarDes.Visible Then btnMarDes.Click;
end;

procedure TfrmFatBaixaEmprestimos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
    fValidaCampos(edtCodCli, True);
end;

procedure TfrmFatBaixaEmprestimos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(rdgTipEmp.Controls[0] As TWinControl);
end;

procedure TfrmFatBaixaEmprestimos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SetLength(arrLogLib, 0);
end;

procedure TfrmFatBaixaEmprestimos.FormCreate(Sender: TObject);
begin
  inherited;
  blnBaixaCTPAVista := (fCfgSis('CTPAVI', varBoolean));
  fFindColumnByName(dbgConsulta, 'SALDIS').Visible := fCfgSis('ESLDBE', VarBoolean);
  qryCadCli := fCriaQuery(Self);
  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;
  strVenFil := '';

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

procedure TfrmFatBaixaEmprestimos.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(objLock);

  inherited;
end;

procedure TfrmFatBaixaEmprestimos.rdgTipEmpEnter(Sender: TObject);
begin
  inherited;

  stlListSelecao.Clear;
  cdsConsulta.Close;

  edtCodCli.Clear;
  edtNomCli.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  pLimpaPesquisa;
end;

procedure TfrmFatBaixaEmprestimos.rdgTipEmpClick(Sender: TObject);
begin
  inherited;
  btnGerPed.Visible := (fCfgSis('PREMFF', VarBoolean) and (rdgTipEmp.ItemIndex = 1));
  btnGerCTP.Visible := (rdgTipEmp.ItemIndex = 0);
end;

procedure TfrmFatBaixaEmprestimos.btnBaiEmpClick(Sender: TObject);
var
  idxTipEmp:Integer;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('', 'Selecione os itens para baixar!', [' &Ok ']);
    Exit;
  End;

  If fQtdABaixarIncorreta Then
    Exit;

  If fTemTinta Then
  Begin
    pMensagemOk('Existe(m) tinta(s) selecionada(s). Somente é possível realizar a baixa através da geração de Faturamento Futuro!');
    Exit;
  End;

  If Not fPodeBaixarEmprestimo Then
  Begin
    fMensagem('', 'Usuário sem permissão para baixar empréstimo!', [' &Ok ']);  
    Exit;
  End;

  idxTipEmp:=rdgTipEmp.ItemIndex;
  If (fMensagem('', 'Confirma a Baixa de Empréstimos?', [' &Sim ', ' &Não ']) = 1) And
     fBaixaEmprestimo(rdgTipEmp.Items[rdgTipEmp.ItemIndex][1], edtCodCli.Text, True, '', (Sender <> btnGerCtp), (Sender = btnGerCtp)) Then

  Begin
    If (fMensagem('', 'Empréstimos baixados com sucesso!' + #13#10 + 'Imprimir comprovante?', ['&Sim', '&Não']) = 1) Then
      pImprimeBaixaEmprestimo;

    pLimpaPesquisa;
    fAbreConsulta(True);
    pLimpaConsulta(idxTipEmp);
  End;

end;

Function TfrmFatBaixaEmprestimos.fBaixaEmprestimo(strEntSai, strCodCli: String; blnConTra: Boolean = True; strCodVen: String = ''; blnMovimentaKardex: Boolean = True; blnGeraContasAPagar: boolean = False): Boolean;
  Var
    blnTailVis: Boolean;
    fltValPag,
    fltTotGer: Double;
    recServicos: TDadosServicos;
    intCtpCon,
    intIndice,
    intContador: integer;
    strHistorico,
    strHistorico2,
    strAutInc,
    strAutDet,
    strClaFis,
    strCtaBai,
    strDocBai,
    strOpeBai,
    strSeqLan,
    strOpeEst,
    strNumDoc,
    strNumDocCTP: string;
    lstBanCtp: TBanCtpRepository;
    blnFilKar: Boolean;
    arrDuplic: TarrDuplicata;
    arrDuplicata: TarrDuplicata;
    strCodErrosAuditoria: String;
Begin
  pZeraDigDuplic(arrDuplic);
  pZeraDigDuplic(arrDuplicata);
  Try
    blnTailVis := pnlTail.Visible;
    pnlTail.Visible := True;
    cdsConsulta.DisableControls;

    pRegistraProgresso('Aguarde, Realizando a baixa dos Empréstimos...', 0, 0);

    //fltTotGer := TAggregateField(cdsConsulta.FieldByName('TOTDOC')).Value;
    fltTotGer := fRetTotGer_e_MontaListaEmprestimos(strCodVen);

    objAuditoriaSaldo.Limpar;

    If blnConTra Then
      fStartTransaction;

    strNumDocBE := fRetSequencial('PRO_BE', VS_strCodEmp, fTamDocCadRec);

    If (fatVenda <> nil) Then
      strNumDoc   := fatVenda.strNumDoc;

    If strEntSai = 'E' Then // Baixando uma entrada (Devolvendo)
    Begin
      strClaFis := '5999';
    End Else
    Begin
      strClaFis := '1999'; // Baixando uma Saida (Recebendo de Volta)
    End;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                           strNumDocBE,                                                   // Numero Documento
                           'BE',                                                          // Espécie
                           VS_strCodEmp,                                                  // Empresa
                           '',                                                            // Transportadora
                           strLoginUsuarioLogado,                                         // Vendedor
                           '',                                                            // Fornecedor
                           strCodCli,                                                     // Cliente
                           'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                           VS_Date,                                                       // Data da Entrada
                           fTime(),                                                       // Hora da Entrada
                           VS_Date,                                                       // Data do Documento
                           '01000',                                                       // Condição de Pagamento
                           '',                                                            // Estado do Cliente / Fornecedor
                           '',                                                            // Nome do Consumidor
                           '',                                                            // Endereço do Consumidor
                           '',                                                            // Bairro do Consumidor
                           '',                                                            // Cep do Consumidor
                           '',                                                            // Cidade do Consumidor
                           '',                                                            // Estado do Consumidor
                           '',                                                            // Telefone do Consumidor
                           0,
                           '',                                                            // CNPJ / CGC
                           '',                                                            // CNPJ / CGC do consumidor
                           '',                                                            // Inscrição estadual do Consumidor
                           '',                                                            // RG do consumidor
                           0.0,                                                           // Base Simples Paulista
                           0.0,                                                           // Base de IPI
                           0.0,                                                           // Aliquota de IPI
                           0.0,                                                           // Total de IPI
                           0.0,                                                           // Base de ICMS
                           0.0,                                                           // Aliquota de ICMS
                           0.0,                                                           // Total de ICMS
                           0.0,                                                           // Valor de Substituição
                           0.0,                                                           // Aliquota de Substituição
                           0.0,                                                           // Base de Substituição
                           0.0,                                                           // Base de Substituição Simulada
                           0.0,                                                           // Desconto Especial
                           fltTotGer,                                                     // Valor Contábil
                           fltTotGer,                                                     // Total dos Itens
                           0.0,                                                           // Total de Custo
                           0.0,                                                           // Total Médio
                           '',                                                            // Tipo de Frete
                           0.0,                                                           // Valor do Frete
                           0.0,                                                           // Peso Bruto
                           0.0,                                                           // Peso Liquido
                           0.0,                                                           // Volume
                           '',                                                            // Especie
                           '',                                                            // Marca
                           '',                                                            // Mensagem 1
                           '',                                                            // Mensagem 2
                           '',                                                            // Mensagem 3
                           '',                                                            // Mensagem 4
                           '',                                                            // Mensagem 5
                           False,                                                         // Indica se Faturado ou nao

                           '',                                                            // Tipo de Faturamento
                           '',                                                            // Numero de Faturamento
                           '',                                                            // Empresa dd Faturamento
                           0,                                                             // Data de Faturamento
                           '',                                                            // Vendedor do Faturamento
                           '',                                                            // Condição de Pagamento do Faturamento
                           False,                                                         // Devolução Especial
                           0,                                                             // Valor do Faturamento

                           0.0,                                                           // Valor Parcela 01
                           0.0,                                                           // Valor Parcela 02
                           0.0,                                                           // Valor Parcela 03
                           0.0,                                                           // Valor Parcela 04
                           0.0,                                                           // Valor Parcela 05
                           0.0,                                                           // Valor Parcela 06
                           0.0,                                                           // Valor Parcela 07
                           0.0,                                                           // Valor Parcela 08
                           0.0,                                                           // Valor Parcela 09
                           0.0,                                                           // Valor Parcela 10
                           0.0,                                                           // Valor Parcela 11
                           0.0,                                                           // Valor Parcela 12
                           arrDuplic,                                                     // arrDuplic
                           '',                                                            // Série
                           'N',                                                           // Nota Especial
                           strClaFis,                                                     // Classificação Fiscal 1
                           '',                                                            // Classificação Fiscal 2
                           '',                                                            // Classificação Fiscal 3
                           '',                                                            // Natureza da Operação
                           0.0,                                                           // Percentual de Desconto
                           strLoginUsuarioLogado,                                         // Codigo do Digitador
                           '',                                                            // Codigo da Condição
                           '',                                                            // Forma de Pagamento
                           0.0,                                                           // Fator para meia nota
                           recServicos,
                           0.0,                                                           // Despesa acessoria
                           '',                                                            // Origem do Documento (V)enda (D)evolução
                           'N',                                                           // Usa controle de entrega
                           '',                                                            // Representante
                           0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                           0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Pis (SERVIÇO)
                           0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                           0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                           0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                                           // Valor de IRPF que foi retido
                           0.0,                                                           // Valor de PIS que foi retido
                           0.0,                                                           // Valor de COFINS que foi retido
                           0.0,                                                           // Valor de CSLL que foi retido
                           '',                                                            // Notas de Documentos Acumulados
                           0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                           0.0,                                                           // Aliquota do PIS (PRODUTOS)
                           0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                           0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                           0.0,                                                           // Valor de SERVIÇO que foi retido
                           '',                                                            // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                                           // Percentual da Seguridade Social
                           0.0,                                                           // Valor da Seguridade Social
                           0.0,                                                           // Valor do IRPF Retido (Produto)
                           0.0,                                                           // Valor do IRPF Devido (Produto)
                           0.0,                                                           // Valor do IRPF Retido (Serviço)
                           0.0,                                                           // Valor do IRPF Devido (Serviço)
                           0.0,                                                           // Valor do PIS Retido (Produto)
                           0.0,                                                           // Valor do PIS Devido (Produto)
                           0.0,                                                           // Valor do PIS Retido (Serviço)
                           0.0,                                                           // Valor do PIS Devido (Serviço)
                           0.0,                                                           // Valor do COFINS Retido (Produto)
                           0.0,                                                           // Valor do COFINS Devido (Produto)
                           0.0,                                                           // Valor do COFINS Retido (Serviço)
                           0.0,                                                           // Valor do COFINS Devido (Serviço)
                           0.0,                                                           // Valor do CSLL Retido (Produto)
                           0.0,                                                           // Valor do CSLL Devido (Produto)
                           0.0,                                                           // Valor do CSLL Retido (Serviço)
                           0.0,                                                           // Valor do CSLL Devido (Serviço)
                           '',                                                            // Ordem de Produção
                           0.0,                                                           // Base Orgão Público
                           0.0,                                                           // ICMS Orgão Público
                           0,                                                             // Número do Conhecimento de Frete
                           '',                                                            // Consumidor final
                           'N',                                                           // Entrega no Faturamento
                           '',                                                            // Cliente de Faturamento
                           '',                                                            // Operador da Expedição
                           '',                                                            // Separador da Expedição
                           '',                                                            // Tabela de Preços utilizada
                           '',
                           'N',                                                           // Entrega Futura
                           FALSE,                                                         // Baixa de Entrega Futura
                           0,                                                             // Margem de Lucro
                           0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                                           // Valor do retido considerando a base acima.
                           'N',                                                           // Gerar produção fora da loja
                           '',                                                            // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                                       // Data de Entrega no Romaneio
                           '',                                                            // Classificação fiscal 4
                           'N',                                                           // AUTO-SERVIÇO
                           '',                                                            // Evento
                           '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                           '',                                                            // Conteúdo do CNFNFE
                           '',                                                            // Motivo da Devolução
                           '',
                           True);                                                         // Imprime Duplicatas na NF-e

    If Result Then
      objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

    If Result Then
    With cdsConsulta Do
    For intIndice := 0 To stlListSelecao.Count - 1 Do
    Begin
      pRegistraProgresso('Aguarde, Realizando a baixa dos Empréstimos...', Succ(intIndice), stlListSelecao.Count);

      If strEntSai = 'E' Then // Baixando uma entrada (Devolvendo)
      Begin
        strClaFis := '5999';
        strOpeEst := 'S';
      End Else
      Begin
        strClaFis := '1999'; // Baixando uma Saida (Recebendo de Volta)
        strOpeEst := 'E';
      End;

      If Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
      Begin
        strAutDet := '';
        If blnMovimentaKardex Then
          blnFilKar := (FieldByName('DET_PROACA').AsString = 'S') or (FieldByName('DET_IDEPRO').AsString <> 'NOR')
        Else
          blnFilKar := True;

        Result := fGravaMovDet(strAutDet,                                                   // Retorna Auto-Incremento por Referencia
                               strAutInc,                                                   // Sequencial do Arquivo Geral
                               strNumDocBE,                                                 // Numero Documento
                               'BE',                                                        // Espécie
                               VS_strCodEmp,                                                // Empresa
                               FieldByName('CODITE').AsString,                              // Cód. Item
                               strLoginUsuarioLogado,                                       // Vendedor
                               '',                                                          // Código Diversos
                               FieldByName('CODMAR').AsString,                              // Código da Marca
                               '',                                                          // Fornecedor
                               strCodCli,                                                   // Cliente
                               VS_Date,                                                     // Data da Entrada
                               fTime(),                                                     // Hora da Entrada
                               VS_Date,                                                     // Data do Documento
                               '01000',                                                     // Condição de Pagamento
                               'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                               '',                                                          // Estado do Fornecedor
                               FieldByName('DESITE').AsString,                              // Descrição do Item
                               FieldByName('REFERE').AsString,                              // Referência do Item
                               FieldByName('CODUNI').AsString,                              // Cód. Unidade
                               FieldByName('CODFOR').AsString,                              // Fornecedor Item
                               FieldByName('QTDBAI').AsFloat,                               // Quantidade do Item
                               FieldByName('UNITAR').AsFloat,                               // Valor Unitario
                               FieldByName('UNIORI').AsFloat,                               // Valor Unitário Original
                               FieldByName('UNIVIS').AsFloat,                               // Valor Unitário Original sem juros
                               RoundTo(FieldByName('UNITAR').AsFloat *
                                       FieldByName('QTDBAI').AsFloat, -2),                  // Total do Item

                               RoundTo(FieldByName('UNITAR').AsFloat *
                                       FieldByName('QTDBAI').AsFloat, -2),                  // Valor Contábil

                               0.0,                                                         // Valor Total de Custo
                               0.0,                                                         // Valor Total Medio
                               0.0,                                                         // % Desconto do Item
                               0.0,                                                         // Valor do Frete
                               0.0,                                                         // Valor do Desconto Especial
                               '',                                                          // Código do Representante
                               '',                                                          // Código do Vendedor 2
                               0.0,                                                         // Percentual de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor 2
                               strClaFis,                                                   // Classificação Fiscal
                               '',                                                          // Código Fiscal
                               0.0,                                                         // Valor IPI
                               0.0,                                                         // Aliquota IPI
                               0.0,                                                         // Base IPI
                               0.0,                                                         // Valor de ICMS
                               0.0,                                                         // Aliquota de ICMS
                               0.0,                                                         // Base de ICMS
                               0.0,                                                         // Valor de Substituição
                               0.0,                                                         // Aliquota de Substituição
                               0.0,                                                         // Base de Substituição
                               0.0,                                                         // Total de Peso
                               0.0,                                                         // Percentual de Base de ICMS
                               0.0,                                                         // Percentual de Redução de Base
                               False,                                                       // Indica se ja esta Faturado

                               '',                                                          // Tipo de Faturamento
                               '',                                                          // Numero de Faturamento
                               '',                                                          // Empresa dd Faturamento
                               0,                                                           // Data de Faturamento
                               strLoginUsuarioLogado,                                       // Vendedor do Faturamento
                               '',                                                          // Condição de Pagamento do Faturamento
                               0,                                                           // Valor do Faturamento

                               'NOR',                                                       // Identificação Produto ( Normal / Outros )
                               FieldByName('INCPIS').AsString,                              // Indice se incide Pis
                               '',                                                          // Série
                               0.0,                                                         // Valor de Despesa Acessória
                               'N',                                                         // Nota Especial
                               '',                                                          // Documento da Devolução
                               '',                                                          // Espécie da Devolução
                               '',                                                          // Empresa da Devolução
                               '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                               '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                               strLoginUsuarioLogado,                                       // Código do Digitador
                               '',                                                          // Codigo da Condição
                               '',                                                          // Forma de Pagamento
                               '',                                                          // Item da Embalagem
                               '',                                                          // Grupo do Item da Embalagem
                               0,                                                           // Quarto da Lazzumiz
                               'N',                                                         // É item em promoção?
                               '',                                                          // Tipo de Tinta
                               0.0,                                                         // Quantidade de Pulsos
                               '',                                                          // Número do pedido de compras
                               '',                                                          // Origem do documento
                               '',                                                          // Pedido de Venda - Número
                               '',                                                          // Pedido de Venda - Espécie
                               '',                                                          // Pedido de Venda - Empresa
                               0,                                                           // Pedido de Venda - Sequencial
                               '',                                                          // Ordem de Produção
                               '',                                                          // Descrição para Nota Fiscal Especial
                               '',
                               0,
                               0,
                               0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                               FieldByName('DET_CODACA').AsString,
                               FieldByName('DET_EMPACA').AsString,
                               (FieldByName('DET_PROACA').AsString = 'S') or (FieldByName('DET_IDEPRO').AsString <> 'NOR'),
                               blnFilkar,
                               'FF',                                                        //  Especie da Entrega Fututa
                               strNumDoc,                                                   //  Documento da Entrega Fututa
                               VS_strCodEmp,                                                //  Empresa da Entrega Fututa
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'N',
                               '',
                               0,
                               0,
                               0,
                               0,
                               fChaveRegistro,
                               FieldByName('DET_NUMLOT').AsString, // strNumLot
                               'N',   // strPigBas
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               'P',
                               RoundTo(FieldByName('UNITAR').AsFloat * FieldByName('QTDBAI').AsFloat, -2));


        If Not Result Then
          Break;

        If Not blnFilkar then
        begin
          Result := fAtualizaEstoqueCadIte(FieldByName('CODITE').AsString,
                                                     strOpeEst,
                                                     FieldByName('QTDBAI').AsFloat,
                                                     0.0,
                                                     FieldByName('DET_NUMLOT').AsString);
        end;

        If Not Result Then
          Break;

        Result := fBaixaDetEmprestimo(FieldByName('AUTOINCREM').AsString, FieldByName('QTDBAI').AsFloat);

        If Not Result Then
          Break;

      End; {If Locate...}

    End; {For...}


    If blnGeraContasAPagar Then
    Begin
      pInicializaImpressaoCP;
      intCtpCon := fRetCtpCon;
      Result := fDigDuplic(arrDuplicata,
                           frmGeraPagamentos.mskCndPag.text,                          //strCndPag
                           0,                                                        //intNumDoc
                           fltTotGer,                                                //curTotal
                           False,                                                    //blnMosTela
                           False,                                                    //blnEditavel
                           False,                                                    //blnHabEditDup
                           fNow,                                                      //dtaDtaBas
                           False,                                                    //blnPergConf
                           0,                                                        //fltImpost
                           'S',                                                      //strUsaChq
                           fRetArred2ParcFornec(frmGeraPagamentos.edtCodFor.Text),   //blnDupsRedondas
                           False,                                                    //blnUsaHist
                           0,                                                        //fltValRec
                           False,                                                    //blnFaturamento
                           Nil,                                                      //arrValores
                           '',                                                     //strEspDoc
                           True,                                                     //blnSabDomFeriadoDiasUteis
                           True,                                                     //blnHabEditValor
                           nil,                                                      //pMostraContaCorrente
                           '',                                                       //strCodCli
                           True,                                                     //blnPerRep
                           False);                                                   //blnValoresPadrao
                           intContador := 0;
      {*****************************************}
      {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
      {**************************************MV*}
      strNumDocCTP := fRetSequencialCadPag;
      strHistorico2 := frmGeraPagamentos.edtHistorico.Text;
      strHistorico := 'BAIXA DE EMPRÉSTIMO REF: AO(S) DOC(S): ' + strDocumentosSelecionados + ' QTD. DOCS: '+ IntToStr(intQtdEPS);

      While (ArrDuplicata[intContador].dtaDtaVen <> '') And
            (intContador < Length(arrDuplicata))        And
            (Result)                                    Do
      Begin
        strCtaBai := '';
        strDocBai := '';
        strOpeBai := '';
        fltValPag := 0;
        strSeqLan := '';

        If (fStatusCndPag(frmGeraPagamentos.mskCndPag.Text) = A_VISTA) And
           (blnBaixaCTPAVista) And (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
        Begin
          lstBanCtp := TBanCtpRepository.Create;
          lstBanCtp.fAdd(strNumDocCTP,
                         'A',
                         '',
                         VS_strCodEmp,
                         frmGeraPagamentos.edtCodFor.Text,
                         strHistorico2,
                         '',
                         frmGeraPagamentos.fraPlanoDeContas.MskCodCta.Text,
                         VS_strCodEmp,
                         0,
                         ArrDuplicata[intContador].curValor,
                         0,
                         0,
                         0,
                         0);

          strSeqLan := fGravaMovBan(frmGeraPagamentos.fraPlanoDeContas.MskCodCta.Text,   // Centro de Custo
                                    frmGeraPagamentos.edtCodPor.Text,   // Portador da Baixa
                                    strLoginUsuarioLogado,                // Operador da Baixa
                                    fNow,                               // Data do Lançamento
                                    fTime(),                            // Hora do Lançamento
                                    fStrZero(strNumDocCTP, 12),            // Numero do Documento
                                    'D',                                // Credito / Debito
                                    VS_strCodEmp,                       // Empresa da Baixa
                                    ArrDuplicata[intContador].curValor, // Valor Do Lançamento
                                    strHistorico,                       //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                                    strHistorico2,                                 // Histórico 2
                                    '',                                 // Cliente da Duplicata
                                    frmGeraPagamentos.edtCodFor.Text,   // Fornecedor da Duplicata
                                    fStrZero(strNumDocCTP, 12),         // Número da Duplicata
                                    0,                                  // Sequencial de Baixa
                                    'A',                                // Parcela da Duplicata
                                    VS_strCodEmp,                       // Empresa da Duplicata
                                    '',                                 // Série
                                    '',                                 // Sequencial de Lançamento
                                    '',                                 // Código do Evento
                                    lstBanCtp.fGetList,                 // Documento da Baixa
                                    0,                                  // Log Bancário
                                    intCtpCon);

          Result := Not fEmptyStr(strSeqLan);
          FreeAndNil(lstBanCtp);

          strCtaBai := frmGeraPagamentos.fraPlanoDeContas.MskCodCta.Text;
          strDocBai := strSeqLan;
          strOpeBai := strLoginUsuarioLogado;
          fltValPag := ArrDuplicata[intContador].curValor;

          If Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0 Then
            ArrDuplicata[intContador].strUsaChq := 'N';

        End;
        Result := Result And fGravaCadPag(Self.Name,
                                  'EMPRESTIMO',
                                   frmGeraPagamentos.edtCodFor.Text,                              // Fornecedor
                                   fStrZero(strNumDocCTP, 12),                                     // Numero da Duplicata
                                   ArrDuplicata[intContador].strSequen,                           // Parcela
                                   VS_strCodEmp,                                                  // Empresa
                                   frmGeraPagamentos.fraPlanoDeContas.MskCodCta.Text,             // Centro de Custo
                                   '',                                                            // Serie do Documento
                                   0,                                                             // Sequencial de Baixa
                                   fNow,                                                          // Data do lançamento
                                   StrToDate(ArrDuplicata[intContador].dtaDtaVen),                // Data de Vencimento
                                   ArrDuplicata[intContador].curValor - fltValPag,                // Valor da Duplicata
                                   ArrDuplicata[intContador].curValor,                            // Valor Original
    //                               ArrDuplicata[intContador].curValor - fltValPag,                // Valor Original
                                   'N',                                                           // Previsão?
                                   'N',                                                           // Veio Boleto
                                   'N',                                                            // Deposito
                                   strHistorico, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDocCTP, 12) + strEspDoc, // Histórico 1
                                   strHistorico2,                                                            // Histórico 2
                                   '',                                                            // Histórico da Baixa
                                   '',                                                            // Portador da Baixa
                                   '',                                                            // Centro de Custo da Baixa
                                   '',                                                            // Documento da Baixa
                                   '',                                                            // Operador da Baixa
                                   0,                                                             // Data do Pagamento
                                   0,                                                             // Valor Pago
                                   0,                                                             // Valor de Juros
                                   0,                                                             // Valor Desconto
                                   VS_strCodEmp,                                                  // Empresa
                                   frmGeraPagamentos.fraCentroCusto.edtCodEve.Text,               // Código do Evento
                                   ArrDuplicata[intContador].strUsaChq,                           // Usa Cheque
                                   frmGeraPagamentos.edtCodPor.Text,                              // Codigo do Portador
                                   '',                                                            // Nro do Documento da Baixa
                                   0.0,                                                           // fltJurSuj,
                                   0.0,                                                           // fltDesSuj: Double;
                                   intCtpCon,                                                     // intSeqCon: Integer;
                                   False,                                                         // blnResCai: Boolean = False;
                                   0,                                                             // intRcxCon: Integer = 0;
                                   '',                                                            // strTipDoc: String = '';
                                   0,                                                             // fltVendor: Double  = 0;
                                   'N',                                                           // strVeioNF: String = '';
                                   '',                                                            // strNotEnt: String = '';
                                   '',                                                            // strNotTip: String = '';
                                   '',                                                            // strCTPCom: String = '';
                                   '',                                                            // strAutInc: String = '';
                                   '',                                                            // strDocTer: String = '';
                                   '',                                                            // strEspTer: String = '';
                                   '',                                                            // strEmpTer: String = '';
                                   '',                                                            // strCliTer: String = '';
                                   'N',                                                            // strUsoCon: String = '';
                                   '',                                                            // strCompet: String = '';
                                   '',                                                            // strCodCliUC: String = '';
                                   '',                                                            // strNumDocUC: String = '';
                                   '',                                                            // strEspDocUC: String = '';
                                   '',                                                            // strCodEmpUC: String = '';
                                   0,                                                             // fltDinhei: Double = 0;
                                   0,                                                             // fltChqAvi: Double = 0;
                                   0,                                                             // fltOrdPag: Double = 0;
                                   0,                                                             // fltRepChq: Double = 0;
                                   '',                                                            // strCodVen: String = '';
                                   0,                                                             // fltJurAnt: Double = 0;
                                   0,                                                             // fltDesAnt: Double = 0;
                                   '',                                                            // strLinDig: String = '';
                                   '',                                                            // strCodBar: String = '';
                                   '',                                                            // strAutCtp: String = '';
                                   ArrDuplicata[intContador].strNFNumDup,                         // strNFNumDup: String = ''): Boolean;
                                   strAutInc,                                                     // strAutoincremBE
                                   '0',
                                   '',
                                   '',
                                   '',
                                   '',
                                   'N');

        Inc(intContador);
      End;
    End;


    If Result Then
    Begin
      pRegistraProgresso('Aguarde... Gravando Log de Liberações', 0, 1);
      pGeraLogLiberacao(strNumDocBE, 'BE', VS_strCodEmp);
      SetLength(arrLogLib, 0);
      pRegistraProgresso('Aguarde... Gravando Log de Liberações', 1, 1);
    End;

    If blnConTra Then
    Begin
      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      If Result Then
        fCommit
      Else
        fRollBack;
    End;

    pnlTail.Visible := blnTailVis;
    cdsConsulta.EnableControls;
    
  Except
    On E: Exception Do
    Begin
      Result := False;
      If blnConTra Then
        fRollBack;
      pMensagensErro(E.Message, '[TfrmFatBaixaEmprestimos.fBaixaEmprestimo]');
    End;
  End;

End;

Function TfrmFatBaixaEmprestimos.fBaixaDetEmprestimo(strAutInc: String; fltQtdBai: Double): Boolean;
  Var
    qryMovDet: TUniQuery;
Begin
  qryMovDet := fCriaQuery;
  With qryMovDet, SQL Do
  Begin
    Clear;
    Add('UPDATE MOVDET SET DET_BAIEMP = IFNULL(DET_BAIEMP,0) + :QTDBAI');
    Add('WHERE AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('QTDBAI').AsFloat  := fltQtdBai;

    ExecSQL
  End;
  FreeAndNil(qryMovDet);

  Result := True;
End;

function TfrmFatBaixaEmprestimos.fPedeTabelaPrecoFF: Boolean;
begin
  Result := True;

  strTabPreFF := '';
  blnTabPreAtual := False;

  If Not fCfgSis('SOTPBE', VarBoolean) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatDigTabPrecoBaixaEmprestimos, frmFatDigTabPrecoBaixaEmprestimos);
    Result := frmFatDigTabPrecoBaixaEmprestimos.ShowModal = mrOk;
    If Result Then
    Begin
      strTabPreFF := frmFatDigTabPrecoBaixaEmprestimos.cbTabPreco.Text;
      blnTabPreAtual := frmFatDigTabPrecoBaixaEmprestimos.rdgDataTab.ItemIndex = 1;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatDigTabPrecoBaixaEmprestimos);
end;

procedure TfrmFatBaixaEmprestimos.btnGerCTPClick(Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count = 0 Then
    Exit;

  pCriarFormularios(TfrmGeraPagamentos, frmGeraPagamentos);
  Try
    If frmGeraPagamentos.ShowModal = mrOk Then
    Begin
      btnBaiEmpClick(Sender);
    End;
  Finally
    FreeAndNil(frmGeraPagamentos);
  End;
end;

procedure TfrmFatBaixaEmprestimos.btnGerPedClick(Sender: TObject);
  Var
    strNumDoc: String;
    strCodPor: String;
    qryAux   : TUniQuery;
    strMsgErroAdicional : String;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('', 'Selecione os itens para geração do Faturamento Futuro (FF)', [' &Ok ']);
    Exit;
  End;

  If fQtdABaixarIncorreta Then
    Exit;

  strCodPor := (fCfgSis('POREMP', varString));

  {********************************************}
  {* VALIDA O PORTADOR DA BAIXA DE EMPRESTIMO *}
  {*****************************************PZ*}
  If (fEmptyStr(fRetNomPortador(strCodPor))) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Configuração "CFG_POREMP" referente ao portador da baixa de Empréstimo, deve ser preenchida!', ['&O k']);
    Exit;
  End;

  If Not fPodeGerarFF Then
  Begin
    fMensagem('', 'Usuário sem permissão para Gerar Faturamento Futuro!', [' &Ok ']);
    Exit;
  End;

  If Not fPedeTabelaPrecoFF Then
    Exit;

  If (fMensagem('', 'Confirma a geração do Faturamento Futuro (FF)?', [' &Sim ', ' &Não ']) = 1) Then
  Begin

    Try

      qryAux := fCriaQuery(Self);

      with qryAux, SQL Do
      Begin
        Add(fSQLVendedores);
        ParamByName('CODCLI').AsString  := edtCodCli.Text;
        ParamByName('CODEMP').AsString  := VS_strCodEmp;

        ParamByName('ESTADO').AsString  := fCadEmp('ESTADO');
        ParamByName('DECQTD').AsInteger := intDecQtd;

        If Not fEmptyDate(mskDtaIni.Text) Then
        Begin
          ParamByName('DTAINI').AsDate  := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDate  := StrToDate(mskDtaFin.Text);
        End;

        Open;
        First;

        While Not Eof Do
        Begin
          cdsConsulta.Filtered := False;
          cdsConsulta.Filter   := ' DET_CODVEN = ' + QuotedStr(FieldByName('DET_CODVEN').AsString) + ' AND QTDBAI > 0 ';
          cdsConsulta.Filtered := True;

          If (cdsConsulta.RecordCount > 0) Then
          Begin
            If fGeraFF(edtCodCli.Text, strNumDoc, strMsgErroAdicional, FieldByName('DET_CODVEN').AsString) Then
              fMensagem('', 'Faturamento Futuro (FF) ' + strNumDoc + ' gerado com sucesso!', [' &Ok '])
            Else
            Begin
              If Not fEmptyStr(strMsgErroAdicional) Then
                pMensagemSonora('Não foi possível gerar o Faturamento Futuro(FF)' + Chr(13) + 'Erros Adicionais: ' + Chr(13) + strMsgErroAdicional )
              Else
                fMensagem('ATENÇÃO!', 'Não foi possível gerar o Faturamento Futuro(FF)', ['&OK']);
            End;
          End;

          Next;
        End;
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatBaixaEmprestimos.btnGerPedClick]');
      End;

    End;

    cdsConsulta.Filtered := False;
    stlListSelecao.Clear;
    pLimpaCamposPesquisaPai;
    fAbreConsulta(True);
    FreeAndNil(qryAux);

  End;

end;

Function TfrmFatBaixaEmprestimos.fChaveRegistro: String;
Begin
  With cdsConsulta Do
  Result := FieldByName('NUMDOC').AsString + '-' +
            FieldByName('ESPDOC').AsString + '-' +
            FieldByName('CODEMP').AsString + '-' +
            FieldByName('IND_PD').AsString;
End;

procedure TfrmFatBaixaEmprestimos.pCarregarCliente(fatVenda: TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(edtCodCli.Text);
  fatVenda.strConPag := '01030';
  fatVenda.strCndFor := fFormataCondPag(fatVenda.strConPag); // Condição de pagamento formatada
  If (fCfgSis('USAFPG', varBoolean)) Then
  Begin
    fatVenda.strCodFpg := '008';           // Código da Forma de Pagamento
    fatVenda.strDesFpg := 'FATURADO';      // Descrição da Forma de Pagamento
  End;
end;

Procedure TfrmFatBaixaEmprestimos.pCriaTemporariaFF(Var fatVenda : TFatVenda);
Begin
  pCriarCdsVenda(Self);
  fatVenda := TFatVenda.CreateInstance('VN');
  fatVenda.strOpcDocTrue := 'BE';
  fatVenda.blnVerEstOrc := False;
  fatVenda.strNomeForm  := 'frmFatVendas';
  fatVenda.strCodTra    := fCfgSis('TRASUG');
  fatVenda.blnBaixaEmprestimos := True;
End;

Function TfrmFatBaixaEmprestimos.fBaixaEmprestimoFF: Boolean;
Begin
  Result := fBaixaEmprestimo('S', edtCodCli.Text, False, strVenFil);
End;

function TfrmFatBaixaEmprestimos.fRecalculaPrecosCondPagto: Boolean;
begin
  Result := fCfgSis('VLRCND', VarBoolean) And
            fCfgSis('USACND', VarBoolean) And (fCfgSis('CNDVEN') = 'I');
end;

function TfrmFatBaixaEmprestimos.fDigitaDescontoEspecial: Boolean;
Var
  frmFatDigDesconto : TfrmFatDigDesconto;
begin
  Try
    pCriarFormularios(TfrmFatDigDesconto, frmFatDigDesconto);

    frmFatDigDesconto.fatVenda        := fatVenda;
    frmFatDigDesconto.fltTotGerAnt    := fatVenda.fltTotGer;
    frmFatDigDesconto.fltDesEspAnt    := 0;
    frmFatDigDesconto.fltPorDesAnt    := 0;

    frmFatDigDesconto.pAtualizaInformacoesVenda;

    frmFatDigDesconto.edtPorDes.Text  := FormatFloat('#,##0.00', 0);
    frmFatDigDesconto.edtDesEsp.Text  := FormatFloat('#,##0.00', 0);

    frmFatDigDesconto.blnValidarValorMinimo := True;

    frmFatDigDesconto.ShowModal;

    Result := frmFatDigDesconto.blnConfirma;

    {*******************************************}
    {* CALCULA TOTAL GERAL AGORA COM IMPOSTOS, *}
    {* FRETE, DESPESAS E SERVICOS              *}
    {**************************************MV***}
    If Result Then
      fatVenda.pCalculaTotGer;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDigitaDescontoEspecial]');
    End;
  End;

  pFreeAndNil(frmFatDigDesconto);
end;

function TfrmFatBaixaEmprestimos.fRetSaldoProduto(strCodIte, strNumLot, strCodAca, strEmpAca: String; blnProAca: Boolean; fltCnv_Ml, fltSal_Ml: Double): Double;
Var
  fltSaldoItemAtu      : Double;
  fltSaldoResItemAtu   : Double;
begin

  Result := 0;

  Try

    fltSaldoItemAtu := fRetSaldosEmpresa(strCodIte,
                                         VS_strCodEmp,
                                         strNumLot);

    If fUsaQtdPendenteEntregaFutura Then
      fltSaldoItemAtu := fltSaldoItemAtu + TEntregaFutura.New(
                                             TParamEF.New()
                                               .CodIte(strCodIte)
                                               .CodEmp(VS_strCodEmp)
                                               .Faturamento(True)
                                             ).Total();

    If blnProAca Then
      fltSaldoItemAtu := TProdAcabado.fRetornaSaldo(strCodAca,strEmpAca,VS_strCodEmp);

    fltSaldoResItemAtu := TSaldoReservado.New(
                            TReservaParametros.New()
                              .EmpresaItem(VS_strCodEmp)
                              .CodigoItem(strCodIte)
                              .CodEmpresa(VS_strCodEmp)
                              .ConverterML(True)
                            ).fGetQuantidade();

    If (fltCnv_Ml > 0) Then
      Result := (fltSaldoItemAtu * fltCnv_Ml) + fltSal_Ml - fltSaldoResItemAtu
    Else
      Result := fltSaldoItemAtu - fltSaldoResItemAtu;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmFatBaixaEmprestimos.pProcessaSaldoEstoqueProdutos]');
  End;

end;

function TfrmFatBaixaEmprestimos.fRetTotGer_e_MontaListaEmprestimos(strCodVen: String = ''): Double;
  Var
    cdsIteTmp: TUniClientDataSet;
    strDoc: string;
begin

  Result := 0;

  Try
    strDocumentosSelecionados := '';

    cdsIteTmp := TUniClientDataSet.Create(Self);
    cdsIteTmp.Data := cdsConsulta.Data;
    cdsIteTmp.Open;
    cdsIteTmp.Filter := 'QTDBAI > 0';

    If Not fEmptyStr(strCodVen) Then
      cdsIteTmp.Filter := cdsIteTmp.Filter + ' AND DET_CODVEN = ' + QuotedStr(strCodVen);

    cdsIteTmp.Filtered := True;
    intQtdEPS := 0;

    While Not cdsIteTmp.Eof Do
    Begin
      Result := Result + cdsIteTmp.FieldByName('UNITAR').AsFloat * cdsIteTmp.FieldByName('QTDBAI').AsFloat;
      strDoc := cdsIteTmp.FieldByName('NUMDOC').AsString + '-EP-' + VS_strCodEmp;
      If Pos(strDoc,  strDocumentosSelecionados) < 1 Then
      begin
        strDocumentosSelecionados :=  strDocumentosSelecionados +  strDoc + ';';
        Inc(intQtdEPS);
      End;   
      cdsIteTmp.Next;
    End;
    //Remove o ultimo ";"
    Delete(strDocumentosSelecionados,length(strDocumentosSelecionados),1);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatBaixaEmprestimos.fRetTotGerfRetTotGer_e_MontaListaEmprestimos]');
  End;

  FreeAndNil(cdsIteTmp);

end;

function TfrmFatBaixaEmprestimos.fExecutarRecalculoPrecosCondPagto: Boolean;
  Var
    objAltCnd: TAlterarPedido;
    strTabPrecoFat: string;
    intIndice: integer;
    frmFatSelecaoTabelaPreco: TfrmFatSelecaoTabelaPreco;
begin
  Try
    Result := True;

    objAltCnd := TAlterarPedido.Create(Self);

    objAltCnd.objVenda := fatVenda;

    objAltCnd.blnRecalculaPrecos := objAltCnd.blnAtualizaTabPreCnd Or
                                    objAltCnd.blnRecalcularPrecosAoMudarCondicaoDePagamento;

    If objAltCnd.blnAtualizaTabPreCnd Then
      objAltCnd.blnAltTabelaPreco := True;

    If fCfgSis('SOLCND',varBoolean) Or fEmptyStr(fatVenda.strCodCnd) Then
    Begin
      Result := fGetCndPagto(fatVenda, False, True);

      If blnManPre Then
        objAltCnd.blnRecalculaPrecos := False;

      If objAltCnd.blnAtualizaTabPreCnd And (Not fEmptyStr(Trim(StringReplace(fatVenda.strCndTpm,'N','',[rfReplaceAll, rfIgnoreCase])))) Then
      Begin
        strTabPrecoFat := fDevolveTabelaPreco(fatVenda.strCndTpm);
        if Length(strTabPrecoFat) > 1 then
        begin
          try
            pCriarFormularios(TfrmFatSelecaoTabelaPreco,frmFatSelecaoTabelaPreco);
            frmFatSelecaoTabelaPreco.cbbTabPre.Clear;
            frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add('');
            for intIndice := 1 to Length(strTabPrecoFat) do
            begin
              frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add(strTabPrecoFat[intIndice]);
            end;
            frmFatSelecaoTabelaPreco.cbbTabPre.ItemIndex := 0;
            frmFatSelecaoTabelaPreco.ShowModal;
            if frmFatSelecaoTabelaPreco.ModalResult = mrOk then
            begin
              strTabPrecoFat := frmFatSelecaoTabelaPreco.cbbTabPre.Text;
            end;
          finally
            pFreeAndNil(frmFatSelecaoTabelaPreco);
          end;
        end;
        fatVenda.strTabPre := strTabPrecoFat;
      End;
    End
    Else
      objAltCnd.pCarregaCondicao(fatVenda.strCodCnd);

    Result := Result And objAltCnd.fCalculaTotalPedido;

    {**********************************************************************}
    {* DIGITA DESCONTO ESPECIAL, SEGUINDO AS MESMAS REGRAS DO FATURAMENTO *}
    {*******************************************************************FC*}
    If Result And fCfgSis('EDIDES', varBoolean) And (Pos(fatVenda.strOpcDoc, fOpcoesNaoMostraDescontoEspecial) <= 0) Then
    Begin
      fatVenda.pCalculaTotGer(False, False);

      Result := fDigitaDescontoEspecial And
                objAltCnd.fCalculaTotalPedido;
    End;

    FreeAndNil(objAltCnd);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

Function TfrmFatBaixaEmprestimos.fGeraFF(strCodCli: String; Var strNumDoc: String; Var strMsgErroAdicional: String; strCodVen: String = ''): Boolean;
  Const
    INT_MAX_PROGRESS = 9;
Begin
  Try
    pnlTail.Visible := True;

    pRegistraProgresso('Aguarde, Iniciando Venda...', 1, INT_MAX_PROGRESS);
    pCriaTemporariaFF(fatVenda);

    pRegistraProgresso('Aguarde, Carregando dados cliente...', 2, INT_MAX_PROGRESS);
    pCarregarCliente(fatVenda);

    if fEmptyStr(fatVenda.strTabPre) then
      fatVenda.strTabPre := '1';

    pRegistraProgresso('Aguarde, Inserindo Produtos...', 3, INT_MAX_PROGRESS);
    Result := fIncluiItens(fatVenda);

    fatVenda.strCodCli := strCodCli;
    pProcessaItensTintaDeMaquina;

    If Result Then
    Begin
      fatVenda.strEspDoc := 'FF';
      fatVenda.strTipFat := 'Faturamento Futuro';

      strVenFil := strCodVen;
      fatVenda.fBaixaEmprestimoFF := fBaixaEmprestimoFF;
      fatVenda.blnBaixaFFEmprestimo := True;

      If fRecalculaPrecosCondPagto Then
      begin
        pRegistraProgresso('Aguarde, Recalculando Preços...', 4, INT_MAX_PROGRESS);
        Result := fExecutarRecalculoPrecosCondPagto;
      End
      Else
      Begin
        fatVenda.pCarregaAliquotasRetencao;

        pRegistraProgresso('Aguarde, Carregando produtos...', 4, INT_MAX_PROGRESS);
        fatVenda.pgbProgresso := pbProgresso;

        fatVenda.pPreencheMatrizFechamento;

        fatVenda.pCalculaPesBruLiq;

        pRegistraProgresso('Aguarde, Calculando preços dos produtos...', 5, INT_MAX_PROGRESS);
        fatVenda.pCalculaTotGer(False, False);

        If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
        Begin
          If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
            fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        End;

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;

        pRegistraProgresso('Aguarde, Calculando preços dos produtos...', 6, INT_MAX_PROGRESS);
        fatVenda.pCalculaTotGer(False, False);

        {**********************************************************************}
        {* DIGITA DESCONTO ESPECIAL, SEGUINDO AS MESMAS REGRAS DO FATURAMENTO *}
        {*******************************************************************FC*}
        If fCfgSis('EDIDES', varBoolean) And (Pos(fatVenda.strOpcDoc, fOpcoesNaoMostraDescontoEspecial) <= 0) Then
        Begin
          If Not fDigitaDescontoEspecial Then
          Begin
            pInicializaTemporaria;
            Result := False;
            Exit;
          End;
        End;

        If fCfgSis('SOLCND',varBoolean) then
        Begin
          If Not fGetCndPagto(fatVenda, True, False) Then
          Begin
            pInicializaTemporaria;
            Result := False;
            Exit;
          End;
        end;

        If (Result) And (Not blnZerTax) Then
        Begin
          fatVenda.pCalculaTaxVpr;
          If fatVenda.fltTaxVpr > 0 Then
            fatVenda.blnTaxVpr := TRUE;
        End;

        pRegistraProgresso('Aguarde, Calculando preços dos produtos...', 7, INT_MAX_PROGRESS);                
        fatVenda.pCalculaTotGer;

        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        fatVenda.pCalculaTotalParaCadRec;

        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
                                                 FAlse, False, False, VS_Date, False, 0, 'N',
                                                 True, False, 0, False, Nil, '', fCfgSis('FSDUDP', varBoolean),
                                                 True, Nil, '', False, True, '', '', Nil, False, False, Nil, False, False, 0, '', fatVenda.strCodCid);

        fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

        pRegistraProgresso('Aguarde, Rateio dos Valores nos produtos...', 8, INT_MAX_PROGRESS);
        fatVenda.pRateiaValores;
      End;

      If fCfgSis('PROFEP', varBoolean) Then
      Begin
        If Not fPedeProfissional(fatVenda) Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      pRegistraProgresso('Aguarde, Gravando ' + fatVenda.strTipFat + '...', 9, INT_MAX_PROGRESS);

      If Result Then
      Begin
        Try
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.strChave := 'FATVENDAS';
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
          frmGravando.ShowModal;

          Result := frmGravando.blnConfirma;

          If Result Then
            strNumDoc := fatVenda.strNumDoc;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message,'[btnGerPedClick - frmGravando]');
            Result := False;
          End;
        End;

        pFreeAndNil(frmGravando);
      End;
    End;

    strMsgErroAdicional := fatVenda.strMsgErroAdicional;

    pnlTail.Visible := False;
        
    FreeAndNil(fatVenda);
    pFreeCdsVenda;

  Except
    On E: Exception Do
    Begin
      Result := False;
      strMsgErroAdicional := fatVenda.strMsgErroAdicional;
      FreeAndNil(fatVenda);
      pMensagensErro(E.Message, '[TfrmFatBaixaEmprestimos.fGeraFF]');
    End;
  End;

  strVenFil := '';
End;

function TfrmFatBaixaEmprestimos.fGetCndPagto(fatVenda: TFatVenda;
                                              blnHabZta: Boolean = True;
                                              blnHabMPr: Boolean = False): Boolean;
  Var
    frmDigCndPagamento : TfrmDigCndPagamento;
begin
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.fraDigCndPagamento.blnCnfDoc         := False;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda          := fatVenda;

    frmDigCndPagamento.fraDigCndPagamento.strCodCli         := fatVenda.strCodCli;

    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text  := fatVenda.strCodCnd;
      frmDigCndPagamento.fraDigCndPagamento.strCcnAnt       := fatVenda.strCodCnd;
    End;

    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text    := fatVenda.strCodFpg;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := fRetDesFpg(fatVenda.strCodFpg);

    If Not fEmptyStr(fatVenda.strCodCnd) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.pCarregaCondicao;
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
    End;

    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := fatVenda.strConPag;

    {*********************************************}
    { CARREGA ESTES DADOS PARA SENHA DE LIBERACAO }
    { PARA ZERAR TAXA DE JUROS                    }
    {******************************************JB*}
    frmDigCndPagamento.fraDigCndPagamento.strCodVen      := fatVenda.strCodVen;
    frmDigCndPagamento.fraDigCndPagamento.strCodDig      := fatVenda.strCodDig;
    frmDigCndPagamento.fraDigCndPagamento.strNTrava      := fatVenda.strNTrava;
    frmDigCndPagamento.fraDigCndPagamento.stlNumLib      := fatVenda.stlNumLib;
    frmDigCndPagamento.fraDigCndPagamento.blnHabZta      := blnHabZta;
    frmDigCndPagamento.fraDigCndPagamento.blnHabMPr      := blnHabMPr;

    frmDigCndPagamento.Caption := frmDigCndPagamento.Caption;

    If (fCfgSis('CNDVEN') = 'F')      And
        fCfgSis('USACND', varBoolean) And
        fCfgSis('PFLCLI', varBoolean) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := fatVenda.fRetornaMargemPraticadaDocumento(frmDigCndPagamento.fraDigCndPagamento.blnIgnMar);
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := fatVenda.fltTotGer;
    End
    Else
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := 0;
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := 0;
    End;

    frmDigCndPagamento.showModal;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;
    If Result Then
    Begin
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
      fatVenda.strCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
      fatVenda.strCodFpg := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;
      fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));

      fatVenda.pAtualizaInformacoesCondPagamento(Nil);

      blnZerTax          := frmDigCndPagamento.fraDigCndPagamento.chkZerTax.Checked;
      blnManPre          := frmDigCndPagamento.fraDigCndPagamento.chkManPre.Checked;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetCndPagto]');
    End;
  End;

  pFreeAndNil(frmDigCndPagamento);
end;

Function TfrmFatBaixaEmprestimos.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';

    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_IMPFED, ';
    strSQL := strSQL + '  G.ITE_ICMSAI, ';
    strSQL := strSQL + '  G.ITE_DESOPE, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatBaixaEmprestimos.fGetItem]');
    End;

  End;
End;

Function TfrmFatBaixaEmprestimos.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte  : TUniQuery;
    intContador: Integer;
    recForTin: TForTin;
    intIndice: Integer;
    recMadeira: TDadosMadeira;
    fltOutValIte : Double;
    fltDesOpeIte : Double;
    fltImpFedIte : Double;
    fltIcmSaiIte : Double;
    fltUnitario  : Double;
    impSubIteEst : TImpostosSubItensEstrutura;
    fltPreVe1Ite,
    fltPreVe2Ite,
    fltPreVe3Ite,
    fltPreVe4Ite,
    fltPreVe5Ite,
    fltPreVe6Ite,
    fltPreVe7Ite: Double;
Begin
  Try
    Result := True;

    qryGenIte := fCriaQuery;

    With cdsConsulta Do
    Begin
      DisableControls;

      intContador := 0;

      fatVenda.strCodVen := FieldByName('DET_CODVEN').AsString;
      fatVenda.strCodVe2 := FieldByName('DET_CODVE2').AsString;
      fatVenda.strCodDig := strLoginUsuarioLogado;
      fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);
      fatVenda.strTipVen := fRetTipoOperador(fatVenda.strCodVen);

      If fEmptyStr(fatVenda.strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
        fatVenda.strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen], False);

      For intIndice := 0 To stlListSelecao.Count - 1 Do
      Begin
        pRegistraProgresso('Aguarde, Inserindo os produtos...', Succ(intIndice), stlListSelecao.Count);

        If Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
        Begin
          inc(intContador);

          Result := fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

          If FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
            Result := IsTintaExistente(FieldByName('DET_IDEPRO').AsString);

          If Not Result Then
            Break;

          {******************************************************************************************}
          {* ITENS COM IDEPRO <> "NOR" SERÃO PROCESSADOS NA PROCEDURE "pProcessaItensTintaDeMaquina"*}
          {***************************************************************************************RN*}
          fltUnitario  := FieldByName('DET_UNITAR').AsFloat - (FieldByName('DET_DESESP').AsFloat / FieldByName('DET_QTDITE').AsFloat);

          If (FieldByName('DET_IDEPRO').AsString = 'NOR') And (Not fEmptyStr(strTabPreFF)) Then
          Begin
            If blnTabPreAtual Then
            Begin
              If qryGenIte.FieldByName('ITE_PREVE' + strTabPreFF).AsFloat > 0 Then
                fltUnitario := qryGenIte.FieldByName('ITE_PREVE' + strTabPreFF).AsFloat;
            End
            Else
            Begin
              If FieldByName('DET_PREVE' + strTabPreFF).AsFloat > 0 Then
                fltUnitario := FieldByName('DET_PREVE' + strTabPreFF).AsFloat;
            End;
          End;

          If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenIte.FieldByName('ITE_DESITE').AsString) > 0,
                                                     FieldByName('DET_CODITE').AsString) Then
          Begin
            impSubIteEst.strCodIte := FieldByName('DET_CODITE').AsString;
            impSubIteEst.strEmpIte := '';
            impSubIteEst.fltUniPai := fltUnitario;
            impSubIteEst.fltQtdPai := FieldByName('QTDBAI').AsFloat;

            fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

            fltOutValIte := impSubIteEst.fltOutVal;
            fltDesOpeIte := impSubIteEst.fltDesOpe;
            fltImpFedIte := impSubIteEst.fltImpFed;
            fltIcmSaiIte := impSubIteEst.fltIcmSai;
            fltPreVe1Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
            fltPreVe2Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
            fltPreVe3Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
            fltPreVe4Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
            fltPreVe5Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
            fltPreVe6Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
            fltPreVe7Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
          End
          Else
          Begin
            fltOutValIte := IIF((FieldByName('DET_IDEPRO').AsString = 'NOR'), qryGenIte.FieldByName('ITE_OUTVAL').AsFloat, 0.00);
            fltDesOpeIte := IIF((FieldByName('DET_IDEPRO').AsString = 'NOR'), qryGenIte.FieldByName('ITE_DESOPE').AsFloat, 0.00);
            fltImpFedIte := IIF((FieldByName('DET_IDEPRO').AsString = 'NOR'), qryGenIte.FieldByName('ITE_IMPFED').AsFloat, 0.00);
            fltIcmSaiIte := IIF((FieldByName('DET_IDEPRO').AsString = 'NOR'), IIF(fCfgSis('IMPCF4') = 'S', fatVenda.fCalculaAliquota(FieldByName('DET_CODITE').AsString, FieldByName('DET_CODEMP').AsString, qryGenIte.FieldByName('ITE_IMPDIR').AsString), qryGenIte.FieldByName('ITE_ICMSAI').AsFloat), 0.00);
            fltPreVe1Ite := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
            fltPreVe2Ite := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
            fltPreVe3Ite := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
            fltPreVe4Ite := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
            fltPreVe5Ite := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
            fltPreVe6Ite := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
            fltPreVe7Ite := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
          End;

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               FieldByName('DET_IDEPRO').AsString,
                                               FieldByName('CODGRU').AsString,
                                               FieldByName('DET_CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               FieldByName('DET_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_CODMAR').AsString,
                                               FieldByName('DET_FORITE').AsString,
                                               FieldByName('DET_REFERE').AsString,
                                               FieldByName('DET_UNIORI').AsFloat,
                                               FieldByName('DET_UNIVIS').AsFloat,
                                               fltUnitario,
                                               0.0,
                                               FieldByName('DET_DESCON').AsFloat,
                                               FieldByName('QTDBAI').AsFloat,
                                               fltUnitario * FieldByName('QTDBAI').AsFloat,
                                               'S',
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat,
                                     {totcus}  fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat * FieldByName('QTDBAI').AsFloat, 2),
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               fltPreVe1Ite,
                                               fltPreVe2Ite,
                                               fltPreVe3Ite,
                                               fltPreVe4Ite,
                                               fltPreVe5Ite,
                                               fltPreVe6Ite,
                                               fltPreVe7Ite,
                                               fCalculaPrecoVenda(2, fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat * FieldByName('QTDBAI').AsFloat, 2), fltUnitario, 0, 0, 0, 0, 0),
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               FieldByName('DET_INCPIS').AsString,
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('QTDBAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               FieldByName('DET_ITECHA').AsString,
                                               FieldByName('DET_ITETIN').AsString,
                                               FieldByName('DET_DESCOR').AsString,
                                               FieldByName('DET_TIPPRE').AsString,
                                               FieldByName('DET_LAZQUA').AsInteger,
                                               FieldByName('DET_TIPEMB').AsString,
                                               0,
                                               0,
                                               FieldByName('DET_PRVTIN').AsFloat,
                                               FieldByName('DET_PRCTIN').AsFloat,
                                               FieldByName('DET_FATTIN').AsFloat,
                                               'N',
                                               FieldByName('DET_ITEEMB').AsString,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               FieldByName('DET_PROMOC').AsString,
                                               0,
                                               0,
                                               0,
                                               0,
                                               IIF(fEmptyStr(FieldByName('DET_SEQTIN').AsString), '', '2'),
                                               fatVenda.fRetPerComGrupo(FieldByName('CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(FieldByName('DET_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               FieldByName('DET_LINLIN').AsString,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               fltUnitario,
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString),
                                               FieldByName('DET_VOLPRO').AsFloat,
                                               intContador,
                                               '',
                                               FieldByName('DET_CODACA').AsString,
                                               FieldByName('DET_EMPACA').AsString,
                                               (FieldByName('DET_PROACA').AsString = 'S') or (FieldByName('DET_IDEPRO').AsString <> 'NOR'),
                                               FieldByName('DET_ESPDOC').AsString,
                                               FieldByName('DET_NUMDOC').AsString,
                                               FieldByName('DET_CODEMP').AsString,
                                     {outval}  fltOutValIte,
                                               0,
                                     {desope}  fltDesOpeIte,
                                     {icmsai}  fltIcmSaiIte,
                                     {impfed}  fltImpFedIte,
                                               0,
                                               '',
                                               '',
                                               '',
                                               FieldByName('DET_TABPRE').AsString,
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               FieldByName('DET_CODDIL').AsString,
                                               FieldByName('DET_PORDIL').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               FieldByName('QTDBAI').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',
                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDITE').AsFloat,
                                      {totcu2} fFormataFloat(FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDITE').AsFloat * FieldByName('QTDBAI').AsFloat, 2),
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               '',
                                               FieldByName('DET_NUMLOT').AsString,
                                               '',
                                               '',
                                               False,
                                               'N',
                                               'NOR',
                                               0,
                                               '',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               IIF(fCfgSis('ACEAUT') = 'V', 0, 1),
                                               True,
                                               '',
                                               '',
                                               '',                                               
                                               0,
                                      {cusite} FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('QTDBAI').AsFloat,
                                               FieldByName('DET_VAL_RT').AsFloat,
                                               FieldByName('DET_TAXJUR').AsFloat,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               False,
                                               False,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               'N',
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                               0.00,
                                               '',
                                               '',
                                               '',
                                               'S',
                                               'N',
                                               '',
                                               '',
                                               '',
                                               '',
                                               False,
                                               -1,
                                               -1,
                                               'N',
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               False,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               'N',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMG').AsFloat);
        End; {If...}

        Next;

      End; {For...}

      EnableControls;
    End; {With}

    FreeAndNil(qryGenIte);

  Except

    On E: ExceptionAutcom Do
    Begin
      cdsConsulta.EnableControls;
      Result := False;
      pMensagemOK(E.Message);
    End;

    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatBaixaEmprestimos.fIncluiItens]');
    End;

  End;

End;

Procedure TfrmFatBaixaEmprestimos.pImprimeBaixaEmprestimo;
  Var
    strNomeArquivo: String;
Begin

  pImprimeFatImp('MOVDET', strNumDocBE, 'BE',
                 VS_strCodEmp, edtCodCli.Text, 'C', '', False, strNomeArquivo, False);

End;

procedure TfrmFatBaixaEmprestimos.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  pnlTail.Visible    := False;
end;

procedure TfrmFatBaixaEmprestimos.pLimpaCamposPesquisaPai;
begin
  edtData.Clear;
  edtNumero.Clear;
  edtString.Clear;
  edtValor.Clear;
end;

procedure TfrmFatBaixaEmprestimos.pLimpaConsulta(idxRdg:Integer=0);
begin
  stlListSelecao.Clear;
  cdsConsulta.Close;
  pnlHeader.Enabled := True;
  objLock.fLock_Unlock('BAIEMP_' + edtCodCli.Text, False, False);
  pSetFocus(rdgTipEmp.Controls[idxRdg] As TWinControl);
end;

procedure TfrmFatBaixaEmprestimos.pProcessaItensTintaDeMaquina;
  Var
    cdsClone : TUniClientDataSet;
    stlDocum : TStringList;
    strDocum : String;
    intConta : Integer;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  stlDocum := TStringList.Create;

  Try
    stlDocum.Clear;

    pCloneDataSet(cdsClone, cdsConsulta);

    cdsClone.Filtered := False;
    cdsClone.Filter := 'IDEPRO <> ' + QuotedStr('NOR') + ' AND QTDBAI > 0 ';
    cdsClone.Filtered := True;

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin

      strDocum := cdsClone.FieldByName('NUMDOC').AsString + '-' +
                  cdsClone.FieldByName('ESPDOC').AsString + '-' +
                  cdsClone.FieldByName('CODEMP').AsString;

      If stlDocum.IndexOf(strDocum) = -1 Then
      Begin
        stlDocum.Add(strDocum);
      End;

      cdsClone.Next;
    End;

    For intConta := 0 To (stlDocum.Count -1) Do
    Begin
      fatVenda.pAcertaTabelaPrecoTinta(Copy(stlDocum.Strings[intConta], 01, 12),
                                       Copy(stlDocum.Strings[intConta], 14, 02),
                                       Copy(stlDocum.Strings[intConta], 17, 03),
                                       True);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.MEssage, '[TfrmFatBaixaEmprestimos.pProcessaItensTintaDeMaquina]');
    End;
  End;

  FreeAndNil(cdsClone);
  FreeAndNil(stlDocum);
end;

procedure TfrmFatBaixaEmprestimos.pProcessaSaldoEstoqueProdutos;
begin

  Try

    fChamaTelaGravando(fProcessaSaldoEstoqueProdutos);

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmFatBaixaEmprestimos.pProcessaSaldoEstoqueProdutos]');
  End;

end;

function TfrmFatBaixaEmprestimos.fPodeBaixarEmprestimo: Boolean;
begin
  Result := True;
  SetLength(arrLogLib, 0);
  If Not fVerificaAcessoSistema('BAIEMPF10', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Empréstimo - [F10] Baixar Empréstimos');

    objLiberacao.strDirAce := 'BAIEMPF10';
    objLiberacao.strMsgSen := 'Baixa de Empréstimo - [F10] Baixar Empréstimos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End;
end;

function TfrmFatBaixaEmprestimos.fPodeGerarFF: Boolean;
begin
  Result := True;
  If Not fVerificaAcessoSistema('BAIEMPF8', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Empréstimo - [F8] Gerar Faturamento Futuro (FF)');

    objLiberacao.strDirAce := 'BAIEMPF8';
    objLiberacao.strMsgSen := 'Baixa de Empréstimo - [F8] Gerar Faturamento Futuro (FF)';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;


    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End;
end;

function TfrmFatBaixaEmprestimos.fProcessaSaldoEstoqueProdutos(pgbProgresso: TcxProgressBar): Boolean;
begin
  With cdsConsulta Do
  Begin
    First;

    pgbProgresso.Properties.Max := RecordCount;

    While Not Eof Do
    Begin
      pInfoStatusGravacao(pgbProgresso, 'Aguarde... Atualizando Saldo de Estoque Disponível do Produto: ' + #13#10 + FieldByName('DET_CODITE').AsString + '-' + Copy(FieldByName('DET_DESCRI').AsString, 1, 20));
      pStepStatusGravacao(pgbProgresso);
      Edit;
      FieldByName('SALDIS').AsFloat := fRetSaldoProduto(FieldByName('DET_CODITE').AsString,
                                                        FieldByName('DET_NUMLOT').AsString,
                                                        FieldByName('DET_CODACA').AsString,
                                                        FieldByName('DET_EMPACA').AsString,
                                                        FieldByName('DET_PROACA').AsString = 'S',
                                                        FieldByName('ITE_CNV_ML').AsFloat,
                                                        FieldByName('ITE_SAL_ML').AsFloat);
      Post;
      Next;
    End;

    First;
    Result := True;

  End;
end;

function TfrmFatBaixaEmprestimos.fQtdABaixarIncorreta: Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := 0 To (stlListSelecao.Count - 1) Do
  Begin
    If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intCnt], []) Then
    Begin
      If cdsConsulta.FieldByName('QTDBAI').AsFloat <= 0 Then
      Begin
        Result := True;
        fMensagem('', 'Item selecionado com quantidade a baixar = 0, não permitido!', ['&OK']);
        Break;
      End;
    End;
  End;
end;

function TfrmFatBaixaEmprestimos.fTemTinta: Boolean;
  Var
    cdsAux: TUniClientDataSet;
    intCont: Integer;
begin
  cdsAux := TUniClientDataSet.Create(Self);
  cdsAux.Data := cdsConsulta.Data;

  cdsAux.Filter := 'IDEPRO <> ' + QuotedStr('NOR');
  cdsAux.Filter := cdsAux.Filter + ' AND AUTOINCREM IN ( ';

  For intCont := 0 To stlListSelecao.Count -1 Do
    cdsAux.Filter := cdsAux.Filter + QuotedStr(stlListSelecao[intCont]) + ', ';

  cdsAux.Filter := LeftStr(cdsAux.Filter, Length(cdsAux.Filter) -2);
  cdsAux.Filter := cdsAux.Filter + ' ) ';
  cdsAux.Filtered := True;

  Result := Not cdsAux.IsEmpty;
  FreeAndNil(cdsAux);
end;

function TfrmFatBaixaEmprestimos.fTravaBaixa: Boolean;
  var
    strTrava : String;
begin
  objLock.pDestravarTodos;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    strTrava := 'BAIEMP_';
    Result := objLock.fLock_Unlock(strTrava + edtCodCli.Text, True, False);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Este cliente já está sendo utilizado por outra estação: ' +
                 fGetHostLock(strTrava + edtCodCli.Text), ['&Ok']);
    End;
  End
  ELSE
      Result := False;
end;

procedure TfrmFatBaixaEmprestimos.pRegistraProgresso(strInfo: String; intPos, intMax: Integer);
begin
  If pnlTail.Visible Then
  Begin
    pbProgresso.Max := intMax;
    pbProgresso.Position := intPos;
    lblInformacao.Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

end.
