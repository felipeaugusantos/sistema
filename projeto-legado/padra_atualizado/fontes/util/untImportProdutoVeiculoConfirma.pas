unit untImportProdutoVeiculoConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untTCadProdutosVeiculoModelo,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxCheckBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  untZClient, cxProgressBar;

type
  TfrmImportProdutoVeiculoConfirma = class(TfrmPaiConfirma)
    cxgProdVeic: TcxGrid;
    cxgProdVeicDBTableView1: TcxGridDBTableView;
    cxgProdVeicLevel1: TcxGridLevel;
    dtsProVe: TDataSource;
    cxgProdVeicDBTableView1CodIte: TcxGridDBColumn;
    cxgProdVeicDBTableView1CodMar: TcxGridDBColumn;
    cxgProdVeicDBTableView1CodMod: TcxGridDBColumn;
    cxgProdVeicDBTableView1AnoIni: TcxGridDBColumn;
    cxgProdVeicDBTableView1AnoFin: TcxGridDBColumn;
    cxgProdVeicDBTableView1Valvul: TcxGridDBColumn;
    cxgProdVeicDBTableView1Cilind: TcxGridDBColumn;
    cxgProdVeicDBTableView1Potenc: TcxGridDBColumn;
    cxgProdVeicDBTableView1Combus: TcxGridDBColumn;
    cxgProdVeicDBTableView1ObsIte: TcxGridDBColumn;
    cxgProdVeicDBTableView1Observ: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
  private
    blnOk: Boolean;
    objCadProdutosVeiculoModelo : TCadProdutosVeiculoModelo;
    function fInsereVeiculos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravaProVei;
    { Private declarations }
  public
    cdsProVei : TZClient;
    { Public declarations }
  end;

var
  frmImportProdutoVeiculoConfirma: TfrmImportProdutoVeiculoConfirma;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmImportProdutoVeiculoConfirma.btnConfirmaClick(Sender: TObject);
var  frmIns: TfrmGravando;
begin
  inherited;
  If cdsProVei.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereVeiculos;
      frmIns.lblGravando.Caption := 'Aguarde... processando Produtos x Veículos...';
      frmIns.Showmodal;
      If blnOk Then
        pMensagemOk('Processo concluído com êxito!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

function TfrmImportProdutoVeiculoConfirma.fInsereVeiculos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsProVei.RecordCount;
  cdsProVei.First;
  cdsProVei.DisableControls;
  fStartTransaction;
  objCadProdutosVeiculoModelo.pIniciaProcesso('', '');
  blnOk := False;
  Try
    Try
      While not cdsProVei.Eof Do
      Begin
        pGravaProVei;

        cdsProVei.Next;
      End;
      if objCadProdutosVeiculoModelo.fGravarComArrayCamposVeiculo then
      begin
        fCommit;
      end;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportProdutoVeiculoConfirma.fInsereVeiculos]');
      End;
    End

  Finally
    cdsProVei.EnableControls;
  End;
end;

procedure TfrmImportProdutoVeiculoConfirma.pGravaProVei;
var
  recCampos: TCamposVeiculo;
begin
  recCampos.strCodIte := cdsProVei.FieldByName('VEI_CODITE').AsString;
  recCampos.strCodModelo := cdsProVei.FieldByName('MOD_CODMOD').AsString;
  recCampos.strCodMarca := cdsProVei.FieldByName('MOD_CODMAR').AsString;
  recCampos.intAnoIni := cdsProVei.FieldByName('MOD_ANOINI').AsInteger;
  recCampos.intAnoFim := cdsProVei.FieldByName('MOD_ANOFIN').AsInteger;
  recCampos.IntValvulas := cdsProVei.FieldByName('MOD_VALVUL').AsInteger;
  recCampos.strCilindrada := cdsProVei.FieldByName('MOD_CILIND').AsString;
  recCampos.intPotencia := cdsProVei.FieldByName('MOD_POTENC').AsInteger;
  recCampos.strCombustivel := cdsProVei.FieldByName('MOD_COMBUS').AsString;
  recCampos.strObservacoes := cdsProVei.FieldByName('MOD_OBSERV').AsString;
  recCampos.strObservacoesProduto := cdsProVei.FieldByName('VEI_OBSERV').AsString;

  objCadProdutosVeiculoModelo.fAdicionar(recCampos);
end;

procedure TfrmImportProdutoVeiculoConfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(objCadProdutosVeiculoModelo) Then
    FreeAndNil(objCadProdutosVeiculoModelo);
end;

procedure TfrmImportProdutoVeiculoConfirma.FormShow(Sender: TObject);
begin
  inherited;
  objCadProdutosVeiculoModelo := TCadProdutosVeiculoModelo.Create;
  dtsProVe.DataSet := cdsProVei;
end;

end.
