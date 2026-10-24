unit untItensCotacaoSemCotacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untCotacaoTypesAndConst;

type

  TfrmItensCotacaoSemCotacao = class(TfrmPaiConfirma)
    rdgOpcao: TRadioGroup;
    Label1: TLabel;
    cxvItens: TcxGridDBTableViewCitel;
    cxlItens: TcxGridLevel;
    cxgItens: TcxGridCitel;
    dtsItens: TDataSource;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensQTDITE: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }

    class function fSelecionaAcaoParaItemsSemFornecedorCotado(cdsItens: TDataSet): TAcaoParaItensSemCotacao;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmItensCotacaoSemCotacao }

class function TfrmItensCotacaoSemCotacao.fSelecionaAcaoParaItemsSemFornecedorCotado(cdsItens: TDataSet): TAcaoParaItensSemCotacao;
  var strFilter: string;
      blnfiltered: Boolean;
      frmItensCotacaoSemCotacao: TfrmItensCotacaoSemCotacao;
begin
  Result :=  taIgnorar;
  pCriarFormularios(TfrmItensCotacaoSemCotacao, frmItensCotacaoSemCotacao);
  blnfiltered := cdsItens.Filtered;
  strFilter := cdsItens.Filter;
  Try
    frmItensCotacaoSemCotacao.dtsItens.DataSet := cdsItens;
    cdsItens.Filtered := False;
    cdsItens.Filter := 'FORESC = ' + QuotedStr('');
    cdsItens.Filtered := True;
    If cdsItens.RecordCount = 0 Then
      Exit;
    frmItensCotacaoSemCotacao.Showmodal;
    Result := taAbortado;
    If frmItensCotacaoSemCotacao.ModalResult = mrOk Then
    Begin
      case frmItensCotacaoSemCotacao.rdgOpcao.ItemIndex of
        0 : Result := taIgnorar;
        1 : Result := taGerarNovaCotacao;
      end;
    End;
  Finally
    FreeandNil(frmItensCotacaoSemCotacao);
    cdsItens.Filtered := False;
    If strFilter <> '' Then
      cdsItens.filter := strFilter;
    If blnfiltered Then
      cdsItens.Filtered := blnfiltered;
  End;
End;

end.
