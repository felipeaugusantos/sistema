unit Contabilidade.View.DemonstracaoFluxoCaixaContasContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiConfirmaContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmDemonstracaoFluxoCaixaContasContabeis = class(TfrmPaiConfirmaContabilidade)
    GridPlancoView: TcxGridDBTableViewCitel;
    GridPlancoLevel: TcxGridLevel;
    GridPlanco: TcxGridCitel;
    dsPlanco: TDataSource;
    GridPlancoViewSEQLAN: TcxGridDBColumn;
    GridPlancoViewCODCON: TcxGridDBColumn;
    GridPlancoViewDESCRI: TcxGridDBColumn;
    procedure GridPlancoViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FStrAutoIncParametros: String ;
    FStrFieldSeqLan: string ;
    FStrFieldCodCon: string ;
    FStrFieldDescri: string ;
    FblnModoEdicao: boolean ;
    procedure SetstrFieldCodCon(const Value: string);
    procedure SetstrFieldDescri(const Value: string);
    procedure SetstrFieldSeqLan(const Value: string);
  public
    { Public declarations }
    property StrAutoIncParametros: String read FStrAutoIncParametros write FStrAutoIncParametros ;
    property blnModoEdicao: Boolean read FblnModoEdicao write FblnModoEdicao ;
    property strFieldSeqLan: string   read FstrFieldSeqLan write SetstrFieldSeqLan;
    property strFieldCodCon: string   read FstrFieldCodCon write SetstrFieldCodCon;
    property strFieldDescri: string   read FstrFieldDescri write SetstrFieldDescri;
  end;

implementation

uses untTypesSistema, Contabilidade.Consultas, untFuncoesSimples ;

{$R *.dfm}

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.FormCreate(Sender: TObject);
begin
  inherited;
  StrFieldSeqLan := 'DFC_SEQLAN' ;
  StrFieldCodCon := 'DFC_CODCON' ;
  StrFieldDescri := 'NCO_DESCRI' ;
  pnlInfo.Caption := 'Tecle / para adicionar ou DEL para excluir contas contábeis!' ;
end;

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.FormShow(Sender: TObject);
begin
  inherited;
  GridPlancoView.OptionsData.Deleting := FblnModoEdicao ;
  pSetFocus(GridPlanco);
end;

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.GridPlancoViewKeyPress(
  Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
  intCnt : integer ;
begin
  inherited;
  if key = '/' then
  begin

    if not FblnModoEdicao then
    begin
      key := #0 ;
      fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
      exit ;
    end;

    If fPesqPlanoContabil(Self, Nil, Nil, Nil, Key, arrSel, False, '', True, True) Then
    Begin
      key := #0 ;
      dsPlanco.DataSet.DisableControls ;
      try
        for intCnt := Low(arrSel) to High(arrSel) do
        begin
          ////evita duplicidade
          if dsPlanco.DataSet.Locate(FStrFieldCodCon, ArrSel[intCnt].strCodigo, [loCaseInsensitive]) then
          begin
            continue ;
          end;
          ///
          dsPlanco.DataSet.Append ;
          dsPlanco.DataSet.FieldByName(FStrFieldSeqLan).AsString := StrAutoIncParametros ;
          dsPlanco.DataSet.FieldByName(FStrFieldCodCon).AsString := ArrSel[intCnt].strCodigo ;
          dsPlanco.DataSet.FieldByName(FStrFieldDescri).AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [ArrSel[intCnt].strCodigo], False);
          dsPlanco.DataSet.Post ;
        end;
      finally
        dsPlanco.DataSet.EnableControls ;
      end;
    End;
  end;
end;

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.SetstrFieldCodCon(
  const Value: string);
begin
  FstrFieldCodCon := Value;
  GridPlancoViewCODCON.DataBinding.FieldName := Value ;
end;

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.SetstrFieldDescri(
  const Value: string);
begin
  FstrFieldDescri := Value;
  GridPlancoViewDESCRI.DataBinding.FieldName := Value ;
end;

procedure TfrmDemonstracaoFluxoCaixaContasContabeis.SetstrFieldSeqLan(
  const Value: string);
begin
  FstrFieldSeqLan := Value;
  GridPlancoViewSEQLAN.DataBinding.FieldName := Value ;
end;

end.
