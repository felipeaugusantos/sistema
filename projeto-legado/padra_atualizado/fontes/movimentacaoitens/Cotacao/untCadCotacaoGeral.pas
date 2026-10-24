unit untCadCotacaoGeral;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, Mask, DB, DBCtrls, DBEditFocus, ComCtrls, untConstantes, UniClientDataSet,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCotacaoGeral = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeNumCot: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    pnlInfCot: TPanel;
    pagCotacao: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tabCotForIte: TTabSheet;
    TabSheet4: TTabSheet;
    pnlFornecedores: TPanel;
    pnlItens: TPanel;
    pnlCotFornecedor: TPanel;
    pnlComparativo: TPanel;
    Label5: TLabel;
    edtNomCmp: TEditFocus;
    edtCodCmp: TEditFocus;
    btnGravar: TBitBtnLocked;
    dbeMulLoj: TDBCheckBox;
    tabAtualizaPreco: TTabSheet;
    pnlAtuPrecos: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pagCotacaoEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pagCotacaoChange(Sender: TObject);
    procedure dbeMulLojClick(Sender: TObject);
    procedure pagCotacaoChanging(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
    Function fCamposOk: Boolean;
    Function fItemOk: Boolean;
    Function fFornecedorOk: Boolean;
    Function fDescartaPrecos: Boolean;
  public
    { Public declarations }
    blnGerarPedidos: Boolean;

    opeOperacao: TTipoOperacao;
    cdsCotacao: TUniClientDataSet;
    dtsCotacao: TDataSource;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadCotacaoGeral: TfrmCadCotacaoGeral;

implementation

uses SysUtils, Variants, untCadCotFornecedor, untCadCotItens, untCadCotItensFornec,
  untCadCotComparativo, untFuncoesSimples, untPaiOrdena, untCadCotAtuPrecos;

{$R *.dfm}

procedure TfrmCadCotacaoGeral.FormCreate(Sender: TObject);
begin
  inherited;

  pagCotacao.ActivePageIndex := 0;
  blnGerarPedidos := FALSE;

end;

procedure TfrmCadCotacaoGeral.FormShow(Sender: TObject);
begin
  inherited;

  dbeNumCot.DataSource := dtsCotacao;
  dbeDescri.DataSource := dtsCotacao;
  dbeDtaCad.DataSource := dtsCotacao;
  dbeDtaFin.DataSource := dtsCotacao;
  dbeMulLoj.DataSource := dtsCotacao;

  frmCadCotItens.strSeqGer := dtsCotacao.DataSet.FieldByName('AUTOINCREM').AsString;
  frmCadCotItens.Dock(pnlItens,pnlItens.BoundsRect);
  frmCadCotItens.cdsCotGer     := cdsCotacao;
  frmCadCotItens.Show;

  edtNomCmp.Text                := fRetNomVendRep(dtsCotacao.DataSet.FieldByName('COT_CODCMP').AsString);

  frmCadCotFornecedor.strSeqGer := dtsCotacao.DataSet.FieldByName('AUTOINCREM').AsString;
  frmCadCotFornecedor.strNumCot := dtsCotacao.DataSet.FieldByName('COT_NUMCOT').AsString;
  frmCadCotFornecedor.strCodEmp := dtsCotacao.DataSet.FieldByName('COT_CODEMP').AsString;
  frmCadCotFornecedor.Dock(pnlFornecedores,pnlFornecedores.BoundsRect);
  frmCadCotFornecedor.Show;

  frmCadCotItensFornec.strSeqGer := dtsCotacao.DataSet.FieldByName('AUTOINCREM').AsString;
  frmCadCotItensFornec.Dock(pnlCotFornecedor,pnlCotFornecedor.BoundsRect);
  frmCadCotItensFornec.Show;

  frmCadCotComparativo.Dock(pnlComparativo,pnlComparativo.BoundsRect);
  frmCadCotComparativo.frmCadCotacaoGeral := Self;
  frmCadCotComparativo.Show;

  frmCadCotAtuPrecos.Dock(pnlAtuPrecos,pnlAtuPrecos.BoundsRect);
  frmCadCotAtuPrecos.Show;

  frmCadCotFornecedor.cdsItens       := frmCadCotItens.cdsConsulta;
  frmCadCotFornecedor.cdsItensFornec := frmCadCotItensFornec.cdsConsulta;
  frmCadCotFornecedor.cdsCotac       := cdsCotacao;

  frmCadCotItens.cdsItensFornec      := frmCadCotItensFornec.cdsConsulta;
  frmCadCotItens.cdsFornecedores     := frmCadCotFornecedor.cdsConsulta;

  frmCadCotFornecedor.pAbreConsulta;

  frmCadCotItensFornec.dbLookCodFor.ListSource := frmCadCotFornecedor.dtsConsulta;
  frmCadCotItensFornec.dtsCotCfo.DataSet       := frmCadCotFornecedor.cdsConsulta;
  frmCadCotItensFornec.pAbreConsulta;

  frmCadCotComparativo.cdsItens        := frmCadCotItens.cdsConsulta;
  frmCadCotComparativo.cdsFornecedores := frmCadCotFornecedor.cdsConsulta;
  frmCadCotComparativo.cdsItensFornec  := frmCadCotItensFornec.cdsConsulta;

  pSetFocus(dbeDescri);

  dbeMulLoj.ReadOnly := Not ((cdsCotacao.State = dsInsert) And (frmCadCotItens.cdsConsulta.IsEmpty));

  If Not dtsCotacao.DataSet.FieldByName('COT_DTAFIN').IsNull Then
  Begin
    frmCadCotItens.pDesabilitaAlteracao;
    frmCadCotItensFornec.pDesabilitaAlteracao;
    frmCadCotFornecedor.pDesabilitaAlteracao;
    frmCadCotComparativo.pDesabilitaAlteracao;

    pnlDados.Enabled  := FALSE;
    btnGravar.Visible := FALSE;
  End;

  pSetFocus(dbeDescri);
end;

function TfrmCadCotacaoGeral.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  blnMudarFoco := TRUE;

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDescri) Then
    Begin

      If fEmptyStr(Trim(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := FALSE;
      End;

    End

    Else If (Sender = edtCodCmp) Then
    Begin

      edtNomCmp.Text := fRetNomVendRep(fRetCodVendedor(edtCodCmp.Text));
      Result := Not fEmptyStr(edtNomCmp.Text);

      If Not Result Then
      Begin
        pMensagemOk('Senha do comprador inválida!')
      End Else
      Begin
        If dtsCotacao.DataSet.State In [dsEdit, dsInsert] Then
          dtsCotacao.DataSet.FieldByName('COT_CODCMP').AsString := fRetCodVendedor(edtCodCmp.Text);

        pagCotacao.ActivePageIndex := 0;
        pSetFocus(frmCadCotItens.edtCodIte);
        blnMudarFoco := FALSE;
      End;

    End

  End;

  If Not Result Then
  Begin
    pagCotacao.ActivePageIndex := 0;
    pSetFocus(Sender);
  End;

end;

procedure TfrmCadCotacaoGeral.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : Case pagCotacao.ActivePageIndex Of
                  0: If Not frmCadCotItens.pnlPesquisa.Visible Then
                       Close;
                  1: If Not frmCadCotFornecedor.pnlPesquisa.Visible Then
                       Close;
                  2: If Not frmCadCotItensFornec.pnlPesquisa.Visible Then
                       Close;
                  3: If Not frmCadCotComparativo.pnlPesquisa.Visible Then
                       Close;
                End;

  End;

  Case pagCotacao.ActivePageIndex Of
    0: frmCadCotItens.FormKeyDown(Sender,Key,Shift);
    2: frmCadCotItensFornec.FormKeyDown(Sender,Key,Shift);
    3: frmCadCotComparativo.FormKeyDown(Sender,Key,Shift);
  End;

end;

procedure TfrmCadCotacaoGeral.pagCotacaoEnter(Sender: TObject);
begin
  inherited;

  blnMudarFoco := FALSE;

end;

Function TfrmCadCotacaoGeral.fItemOk: Boolean;
Begin
  If frmCadCotItens.cdsConsulta.IsEmpty Then
  Begin
    Result := FALSE;
    fMensagem('ATENÇÃO!', 'Não há itens na cotação!', ['&O k']);
  End

  Else Result := TRUE;
End;

Function TfrmCadCotacaoGeral.fFornecedorOk: Boolean;
Begin
  Result := TRUE;

  If frmCadCotFornecedor.cdsConsulta.State = dsEdit Then
    frmCadCotFornecedor.cdsConsulta.Post;

  If frmCadCotFornecedor.cdsConsulta.IsEmpty Then
  Begin
    Result := FALSE;
    fMensagem('ATENÇÃO!', 'Não há fornecedores na cotação!', ['&O k']);
  End Else
  With frmCadCotFornecedor.cdsConsulta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If FieldByName('DTAENT').IsNull Then
      Begin
        Result := FALSE;

        pagCotacao.ActivePage := tabCotForIte;
        frmCadCotItensFornec.dbLookCodFor.KeyValue := FieldByName('CODFOR').AsString;
        frmCadCotItensFornec.pSetaFiltro;

        fMensagem('ATENÇÃO!', 'Informe a data de entrega!', ['&O k']);

        pSetFocus(frmCadCotItensFornec.dbeDtaEnt);
        Break;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(FieldByName('CONPAG').AsString)) Or
             (Not fValidaCndPag(FieldByName('CONPAG').AsString)) Then
      Begin
        Result := FALSE;

        pagCotacao.ActivePage := tabCotForIte;
        frmCadCotItensFornec.dbLookCodFor.KeyValue := FieldByName('CODFOR').AsString;
        frmCadCotItensFornec.pSetaFiltro;

        If fEmptyStr(fTiraCaracEspeciais(FieldByName('CONPAG').AsString)) Then
          fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k'])
        Else
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);

        pSetFocus(frmCadCotItensFornec.dbeConPag);
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;

End;

procedure TfrmCadCotacaoGeral.dbeMulLojClick(Sender: TObject);
begin
  inherited;

  If Assigned(frmCadCotItens) then
  Begin
    frmCadCotItens.pSetaMultiLojas;
  End;
end;

Function TfrmCadCotacaoGeral.fCamposOk: Boolean;
Begin
  Result := fVerificaCampos And
            fItemOk And
            fFornecedorOk;
End;

procedure TfrmCadCotacaoGeral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If modalResult = mrOk Then
  Begin

    If (Not fDescartaPrecos) Or (Not fCamposOk) Then
      Action := caNone;

  End Else
  Begin
    If (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 2) Then
      Action := caNone;
  End;

end;

procedure TfrmCadCotacaoGeral.pagCotacaoChange(Sender: TObject);
begin
  inherited;

  If frmCadCotFornecedor.cdsConsulta.State = dsEdit Then
    frmCadCotFornecedor.cdsConsulta.Post;

  Case pagCotacao.ActivePageIndex Of
    0: pSetFocus(frmCadCotItens.edtCodIte);
    1: pSetFocus(frmCadCotFornecedor.edtCodFor);
    2: Begin
         If (frmCadCotItensFornec.dbLookCodFor.KeyValue = Null) Then
         Begin
           frmCadCotItensFornec.dbLookCodFor.KeyValue := frmCadCotFornecedor.cdsConsulta.FieldByName('CODFOR').AsString;
           frmCadCotItensFornec.pSetaFiltro;
         End;

         pSetFocus(frmCadCotItensFornec.dbLookCodFor);

         frmCadCotItensFornec.dbeDtaEnt.Enabled := Not frmCadCotFornecedor.cdsConsulta.IsEmpty;
         frmCadCotItensFornec.dbeConPag.Enabled := Not frmCadCotFornecedor.cdsConsulta.IsEmpty;
       End;
    3: Begin
         frmCadCotComparativo.pAbreConsulta;
         pSetFocus(frmCadCotComparativo.dbgConsulta);
       End;
    4: Begin
         frmCadCotComparativo.pAbreConsulta(True);
         pSetFocus(frmCadCotAtuPrecos.cxgItens);
       End;

  End;

end;

Function TfrmCadCotacaoGeral.fDescartaPrecos: Boolean;
Begin
  Result := Not ((pagCotacao.ActivePage = tabAtualizaPreco) And
     frmCadCotAtuPrecos.cdsItensAtuPre.fTemAlteracaoManual And
     (Not fPergunta('Há alterações manuais no preço de venda que não foram ' + #13#10 +
                    'atualizadas no cadastro de produtos.' + #13#10 +
                    'Ao sair dessa página elas serão descartadas. Continua?')) );
End;

procedure TfrmCadCotacaoGeral.pagCotacaoChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  If Not fDescartaPrecos Then
   AllowChange := False;

end;

end.
