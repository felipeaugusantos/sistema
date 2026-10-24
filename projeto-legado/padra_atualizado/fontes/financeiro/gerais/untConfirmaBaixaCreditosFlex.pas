unit untConfirmaBaixaCreditosFlex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, System.StrUtils,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  BitBtnLockedIncrem, ComCtrls, untZClient, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, untBaiCreFlex, untFuncoesSimples, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCadCtaPagarSimples, untCadPag;

type
  TfrmConfirmaBaixaCreditosFlex = class(TfrmPaiConfirma)
    dtsBaiCre: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsTitulo1: TcxStyle;
    cxsTitulo2: TcxStyle;
    cxsFatura: TcxStyle;
    cxsTitulo3: TcxStyle;
    cxsEntFut: TcxStyle;
    prbProgresso: TProgressBar;
    cxgConsultaDBTableView: TcxGridDBTableView;
    cxgConsultaLevel1: TcxGridLevel;
    cxgConsulta: TcxGrid;
    cxgConsultaVENREP: TcxGridDBColumn;
    cxgConsultaVALSEL: TcxGridDBColumn;
    cxgConsultaPEREMP: TcxGridDBColumn;
    cxgConsultaVALEMP: TcxGridDBColumn;
    cxgConsultaPEVERE: TcxGridDBColumn;
    cxgConsultaVRVERE: TcxGridDBColumn;
    cxgConsultaMARDES: TcxGridDBColumn;
    cxgConsultaAUTINC: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strVendedorSemForn: string;
    strCaptionForm: string;
    strDtaVenc: string;
    strCodCta: string;
    strCodPor: string;
    procedure pAjustarNomeColunas;
    function fGravaContasPagar: Boolean;
  public
    objBaiCre : TBaiCreFlex;
    blnConfirma : Boolean;
    blnConcil : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmConfirmaBaixaCreditosFlex: TfrmConfirmaBaixaCreditosFlex;

implementation

{$R *.dfm}

function TfrmConfirmaBaixaCreditosFlex.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;

procedure TfrmConfirmaBaixaCreditosFlex.pAjustarNomeColunas;
begin
  cxgConsultaVENREP.Caption := 'VENDEDOR';
  cxgConsultaPEVERE.Caption := '% VEN.';
  cxgConsultaVRVERE.Caption := 'VR. VENDEDOR';
end;

procedure TfrmConfirmaBaixaCreditosFlex.btnConfirmaClick(Sender: TObject);
  Var
    frmCadCtaPagar: TfrmCadCtaPagarSimples;
    blnGerarCtaPagar: Boolean;
begin
  inherited;

  blnGerarCtaPagar := False;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If (fCfgSis('CTPFLE', varBoolean)) And (fCfgSis('USAFLE', varBoolean)) Then
    blnGerarCtaPagar := fMensagem('', 'Gravar Contas a Pagar?', ['&Sim', '&Não'], 1) = 1;

  If (blnGerarCtaPagar) Then
  Begin
    pCriarFormularios(TfrmCadCtaPagarSimples, frmCadCtaPagar);
    Try
      frmCadCtaPagar.ShowModal;
      If Not (frmCadCtaPagar.ModalResult = mrOk) Then
        Exit;

      strCaptionForm := frmCadCtaPagar.Caption;
      strCodCta      := frmCadCtaPagar.edtCodCta.Text;
      strDtaVenc     := frmCadCtaPagar.mskDtaVenc.Text;
      strCodPor      := frmCadCtaPagar.edtCodPor.Text;
    Finally
      pFreeAndNil(frmCadCtaPagar);
    End;
  End;

  fStartTransaction;
  Try
    blnConfirma := True;

    If objBaiCre.fLancarCreditosDebitosPartesSintetico(IIF(Not blnConcil, 'D', 'C')) Then
    Begin
      objBaiCre.pGravarLancamentoConciliado(blnConcil);
      blnConfirma := True;
    End;

    If (blnConfirma) And (blnGerarCtaPagar) Then
      blnConfirma := fGravaContasPagar;

    If (blnConfirma) Then
      fCommit
    Else
      fRollBack;

    If ((blnConfirma) And (blnGerarCtaPagar) And (Not (fEmptyStr(strVendedorSemForn)))) Then
      fMensagem('AVISO!', 'Os operadores: '+strVendedorSemForn+' não possuem fornecedor vinculado e portanto não geraram Contas A Pagar!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Lançamento de Contas a Pagar]');
    End;
  End;
end;

function TfrmConfirmaBaixaCreditosFlex.fGravaContasPagar: Boolean;
  Var
    objParametrosCtaPagar: TParametrosContasAPagar;
    strCodVend: String;
    strCodFor: String;
begin
  Result := False;

  objParametrosCtaPagar := TParametrosContasAPagar.Create;
  Try
    dtsBaiCre.DataSet.First;
    strVendedorSemForn := '';

    While Not dtsBaiCre.DataSet.Eof Do
    Begin
      strCodVend := dtsBaiCre.DataSet.FieldByName('CODOPE').AsString;
      strCodFor  := fRetCodFornecedorOperador(strCodVend);

      If Not (fEmptyStr(strCodFor)) Then
      Begin
        objParametrosCtaPagar.strNomeFormLogCtp  := strCaptionForm;
        objParametrosCtaPagar.strDescricaoLotCtp := 'CONCILIAÇÃO FLEX';
        objParametrosCtaPagar.strCodCta          := strCodCta;
        objParametrosCtaPagar.strDtaVenc         := strDtaVenc;
        objParametrosCtaPagar.strCodPor          := strCodPor;
        objParametrosCtaPagar.strHistorico       := 'CONCILIAÇÃO DE CRÉDITOS/DÉBITOS FLEX - VENDEDOR: ' + strCodVend + '-' + fRetNomVendRep(strCodVend);
        objParametrosCtaPagar.strCodFor          := strCodFor;
        objParametrosCtaPagar.strNumDoc          := dtsBaiCre.DataSet.FieldByName('NUMDOC').AsString;
        objParametrosCtaPagar.fltValorDupli      := dtsBaiCre.DataSet.FieldByName('VLVERE').AsFloat;
        objParametrosCtaPagar.strParcela         := 'A';
        objParametrosCtaPagar.strDeposito        := 'N';
        objParametrosCtaPagar.strVeioNF          := 'N';
        objParametrosCtaPagar.strUsaCheque       := 'N';
        objParametrosCtaPagar.strPrevisao        := 'N';
        objParametrosCtaPagar.strPagAntecipado   := 'N';
        objParametrosCtaPagar.strUsoEConsumo     := 'N';
        objParametrosCtaPagar.strVeioBoleto      := 'N';

        Result := fGravarContasAPagar(objParametrosCtaPagar);
        If (Not Result) Then
          Exit;
      End
      Else
      Begin
        strVendedorSemForn := IfThen(strVendedorSemForn.IsEmpty, '', strVendedorSemForn + ', ') + strCodVend;
        Result := True;
      End;

      dtsBaiCre.DataSet.Next;
    End;
  Finally
    pFreeAndNil(objParametrosCtaPagar);
  End;
end;

procedure TfrmConfirmaBaixaCreditosFlex.FormActivate(Sender: TObject);
begin
  inherited;

  pAjustarNomeColunas;
  dtsBaiCre.DataSet := objBaiCre.DataSetBaiCreSin;

  If (dtsBaiCre.DataSet.IsEmpty) Then
    fMensagem('', 'A somatória dos valores selecionados precisa resultar em um valor positivo.', ['OK'])
  Else
    btnConfirma.Enabled := True;

  pSetFocus(cxgConsulta);
end;

procedure TfrmConfirmaBaixaCreditosFlex.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  blnConcil := False;
end;

procedure TfrmConfirmaBaixaCreditosFlex.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    DataSet : TDataSet;
begin
  inherited;

  If Assigned(cxgConsultaDBTableView.DataController.DataSource.DataSet) Then
    DataSet := cxgConsultaDBTableView.DataController.DataSource.DataSet
  Else
    DataSet := Nil;

  If (Assigned(DataSet)) And
     (DataSet.Active) And
     (Not DataSet.IsEmpty) Then
  Begin
    Case Key Of
      VK_F10 : btnConfirma.Click;
    End;
  End;
end;

end.
