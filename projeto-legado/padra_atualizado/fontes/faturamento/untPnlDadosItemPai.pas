unit untPnlDadosItemPai;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, untClassPanelCx, untLegendasItem, UniClientDataSet,
  untTypesSistema, untFuncoesSimples, Vcl.StdCtrls, BitBtnLockedIncrem;

type
  TFrmPnlDadosItemPai = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
  private
  protected
    procedure pExibeItensVendidos;
    procedure pExibeItensComprados;

    procedure pMostraComposicaoPrecoCusto(strCodIte: String);
  public
    cdsLegendas: TLegendasItem;

    intPraMedio: Integer;
    strTabPre  : String;
    strNomForm : String;
    strCodVen  : String;
    strCodDig  : String;
    strCodCli  : String;
    strEmprCD  : String;
    cdsConsulta: TUniClientDataSet;
    blnFaturamento: Boolean;
    blnPedCorte  : Boolean;
    blnExibirVrUnitarioPedCompraGrid: Boolean;
    strOpcDoc: String;
    strSenVen: String;
    procVendasPerdidas: TProcVendasGenerica;
    procRelVendasPerdidas: TProcRelVendasGenerica;

    strEmpIte,
    strEmpSal: String;
    blnExiSalDisCD: Boolean;

    btnConfirma: TBitBtnLocked;

    objPanel: TPanelCx;

    constructor Create(AOwner: TComponent); reintroduce; virtual;

    procedure pcdsConsultaScroll(blnProcessMessage: Boolean = True); virtual;

    Class procedure pExibePedidosDeCompraGrid(strCodIte, strDesIte: String; blnExibirVrUnitarioPedCompraGrid: Boolean);

  end;

  TfrmPnlDadosItemPaiClass = Class Of TFrmPnlDadosItemPai;

implementation

{$R *.dfm}

uses
  untCadProdutosCompCusto,
  untRelFatVendasCliente,
  untFuncoesRel, untFuncoesRel2,
  TypesRel, untRelEstPedCompraGrid;

{ TFrmPnlDadosItemPai }

constructor TFrmPnlDadosItemPai.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TFrmPnlDadosItemPai.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //
end;

procedure TFrmPnlDadosItemPai.pcdsConsultaScroll(blnProcessMessage: Boolean);
begin

end;

procedure TFrmPnlDadosItemPai.pExibeItensComprados;
begin

  If Not fVerificaAcessoSistema('ITECMP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Comprados!', ['&O k']);
    Exit;
  End;

 If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(73, 5226, [],
                        ['CODITE','DESITE'],
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString,
                        cdsConsulta.FieldByName('ITE_DESITE').AsString],
                        nil,
                        nil,
                        False);
  End;

end;

procedure TFrmPnlDadosItemPai.pExibeItensVendidos;
begin
  If Not fVerificaAcessoSistema('ITEVEN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Vendidos!', ['&O k']);
    Exit;
  End;

  pCriarFormularios(TfrmRelFatVendasCliente, frmRelFatVendasCliente);

  Try
    Try
      frmRelFatVendasCliente.blnSenha        := False;
      frmRelFatVendasCliente.blnFaturamento  := False;
      frmRelFatVendasCliente.blnCliCons      := False;
      frmRelFatVendasCliente.blnConsultaItem := True;

      frmRelFatVendasCliente.mskLinhaGrupo.Enabled := False;
      frmRelFatVendasCliente.edtProdutos.Enabled   := False;
      frmRelFatVendasCliente.edtProdutos.Text      := cdsConsulta.FieldByName('ITE_CODITE').AsString;
      frmRelFatVendasCliente.edtProdutosExit(frmRelFatVendasCliente.edtProdutos);

      frmRelFatVendasCliente.ShowModal;;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnItensVendClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmRelFatVendasCliente);
  End;
end;

Class procedure TFrmPnlDadosItemPai.pExibePedidosDeCompraGrid(strCodIte, strDesIte: String; blnExibirVrUnitarioPedCompraGrid: Boolean);
Var
  strExibirFornec: String;
begin
  If Not fVerificaAcessoSistema('CPPECG', strLoginUsuarioLogado) Then
  begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  end;

  try
    pCriarFormularios(TfrmRelEstPedCompraGrid, frmRelEstPedCompraGrid);
    frmRelEstPedCompraGrid.strCodIte := strCodIte;
    frmRelEstPedCompraGrid.strDesIte := strDesIte;
    frmRelEstPedCompraGrid.strExiFor := strExibirFornec;
    frmRelEstPedCompraGrid.blnOriConsulPro := True;
    frmRelEstPedCompraGrid.blnExibirUnitario:= blnExibirVrUnitarioPedCompraGrid;
    frmRelEstPedCompraGrid.ShowModal;
  finally
    FreeAndNil(frmRelEstPedCompraGrid);
  end;
end;

procedure TFrmPnlDadosItemPai.pMostraComposicaoPrecoCusto(strCodIte: String);
  Var
    frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
  Try
    Try
      frmCadprodutosCompCusto.strCodIte := strCodIte;
      frmCadprodutosCompCusto.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPnlDadosItem.pMostraComposicaoPrecoCusto]');
      End;
    End;
  Finally
    pFreeAndNil(frmCadprodutosCompCusto);
  End;
end;

end.
