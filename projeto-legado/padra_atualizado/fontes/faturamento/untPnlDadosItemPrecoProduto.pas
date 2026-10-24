{***************************************************************}
{* TELA DO PAINEL CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{************************************************************JU*}
unit untPnlDadosItemPrecoProduto;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DBMemoFocus, Mask, DBEditFocus, Buttons,
  EditFocus, UniClientDataSet, DB, Uni, ActnList, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxColorComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, untLegendasItem, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, untZClient, cxNavigator, untTypesSistema, untFuncoesSimples,
  untClassPanelCx, cxGridDBTableView, cxGridCitel,
  untGerenciaPropriedadesComponentes, cxProgressBar, Vcl.Menus, cxContainer, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  cxInplaceContainer, cxVGrid, cxCurrencyEdit, cxTextEdit, untSaldoLojas,
  untPnlDadosItem, MemoFocus, System.Math, untVisualizarAplicacaoProduto,
  untRelacSimilaridade, untCadArmazem;


type
  TfrmPnlDadosItemPrecoProduto = class(TfrmPnlDadosItem)
    pnlDadosItem: TPanel;
    dtsConsulta: TDataSource;
    popAtalhos: TPopupMenu;
    mnuAgregados: TMenuItem;
    mnuReqCompra: TMenuItem;
    cxsGrid: TcxStyleRepository;
    cxsSaldos: TcxStyle;
    cxsSaldosDisponivel: TcxStyle;
    pnlRodape: TPanel;
    btnExecutaTarefa: TBitBtnLocked;
    cxsSaldosML: TcxStyle;
    cxsSaldosCD: TcxStyle;
    cxsSaldosCDML: TcxStyle;
    cxsSaldosMLDisponivel: TcxStyle;
    cxsSaldosCDDisponivel: TcxStyle;
    cxsSaldosCDMLDisponivel: TcxStyle;
    cxsValorDisponivel: TcxStyle;
    btnImgSite: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    Function fValidaCampos(arrCampo: Array Of String): Boolean;

  public
    { Public declarations }

    procedure pResetatmrAtualizarDados; override;
    procedure pOnDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string); override;
    procedure pSetPnlDadosItemVisible(AVisible: Boolean); override;
    procedure pAtualizarAplicacao; override;

    procedure pIniciouNavegacaoGridConsulta; override;
    procedure pParouNavegacaoGridConsulta; override;

   Published
  end;

implementation

uses  untFatMostraProdSimilar, untConstantes,
      untFatMostraPedSalRes, untFatMostraEstoqueEmp,
      untFuncoesRel, untFuncoesRel2, TypesRel,
      untCadProdutosCompCusto,
      untCadPro, untCadProFoto,
      untModuloFatImp, untCfgRel, StrUtils, untRelFatVendasCliente,
      untIteBar, untMostraEstruturas,
      untGetMetragem, untMostraLegendasItem,
      untControleSepAvulsa, untConsultaOrcPesqItem,
      untGravando, untCadProFotoURL, untFuncoesImagem,
      untFatConsVendasAntigas, untImagens, untIFatReservaSaldo,
      untTFatReservaSaldo, untIFatEntregaFutura, untTFatEntregaFutura, untRelEstPedCompraGrid;

{$R *.dfm}

Function TfrmPnlDadosItemPrecoProduto.fValidaCampos(arrCampo: Array Of String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not Assigned(cdsConsulta.FindField(arrCampo[intContador])) Then
    Begin
      Result := False;
      Exit;
    End;
End;

procedure TfrmPnlDadosItemPrecoProduto.btnExecutaTarefaClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    TfrmCadProdutosCompCusto.pMostraComposicaoPrecoCusto(cdsConsulta.FieldByName('ITE_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);

end;



procedure TfrmPnlDadosItemPrecoProduto.pAtualizarAplicacao;
begin
  inherited;

end;

procedure TfrmPnlDadosItemPrecoProduto.pIniciouNavegacaoGridConsulta;
begin
  inherited;
end;


procedure TfrmPnlDadosItemPrecoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F4 :
      If (Shift = [ssCtrl]) Then
        btnExecutaTarefaClick(Sender);
  End;

  case Key of
    VK_F4: Key := 0;
  End;

end;


procedure TfrmPnlDadosItemPrecoProduto.FormShow(Sender: TObject);
begin
  inherited;
  If fEmptyStr(strEmpSal) Then
    strEmpSal := VS_strCodEmp;

  //Ajusta Componentes do Rodape de acordo com os posicionamentos e valores utilizados da ultima vez

  dtsConsulta.DataSet := cdsConsulta;

  if (not cdsConsulta.Active) then
    cdsConsulta.Open;

  cdsConsulta.First;
end;


procedure TfrmPnlDadosItemPrecoProduto.pParouNavegacaoGridConsulta;
begin
  inherited;
  If (Not Self.Showing) Then
    Exit;
end;


procedure TfrmPnlDadosItemPrecoProduto.pResetatmrAtualizarDados;
begin
  inherited;

end;

procedure TfrmPnlDadosItemPrecoProduto.pSetPnlDadosItemVisible(AVisible: Boolean);
begin
  inherited;
  pnlDadosItem.Visible := AVisible;
end;

procedure TfrmPnlDadosItemPrecoProduto.pOnDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
 {}
end;


end.


