unit untEntFreConGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untEntFreConLista, cxCurrencyEdit, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFrmManipulaContasPagarPrevisaoNao;

type
  TfrmEntFreConGrid = class(TfrmPaiEdit)
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    cxgFretesView: TcxGridDBTableView;
    cxgFretesLevel1: TcxGridLevel;
    cxgFretes: TcxGrid;
    cxgFretesViewColumn1: TcxGridDBColumn;
    cxgFretesViewColumn2: TcxGridDBColumn;
    cxgFretesViewColumn3: TcxGridDBColumn;
    cxgFretesViewColumn4: TcxGridDBColumn;
    cxgFretesViewColumn5: TcxGridDBColumn;
    cxgFretesViewColumn6: TcxGridDBColumn;
    cxgFretesViewColumn7: TcxGridDBColumn;
    btnGravar: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnGravou: Boolean;
  public
    { Public declarations }
    objLisFre: TFreConLista;
    arrDuplicata: TarrDuplicataPointer;
  end;

implementation

uses
  untEntFreCon,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntFreConGrid.btnAlterarClick(Sender: TObject);
begin
  inherited;

  objLisFre.pAlteraConhecimento(False, arrDuplicata);
end;

procedure TfrmEntFreConGrid.btnExcluirClick(Sender: TObject);
begin
  inherited;
  objLisFre.pExcluiConhecimento;
end;

procedure TfrmEntFreConGrid.btnGravarClick(Sender: TObject);
var
  LstrNumDoc,
  LstrCodFor,
  LstrSerie,
  LstrDtaDoc,
  LstrPrevis : String ;
begin
  inherited;

  If Not btnGravar.Visible Then
    Exit;

  If objLisFre.RecordCount = 0 Then
  Begin
    pMensagemOk('Nenhum conhecimento digitado!');
    Exit;
  End;

  If (objLisFre.tipRatFrete = trfInformarPercentuais) And
     (Not TFreCon.fValidaRateioPercentual(objLisFre.cdsRateioProdutos)) Then
  Begin
    pMensagemOk('A soma do percentual dos fretes deve ser igual a 100%!');
    Exit;
  End;

  If fPergunta('Confirma a gravação do conhecimento de frete?') Then
  Begin
    blnGravou := objLisFre.fConfirmaFreConhecimentoVariasNotas;

    If blnGravou Then
    Begin
      pMensagemOk('Gravação concluida com sucesso!');
      Close;
    End;
  End;

  If objLisFre.RecordCount = 1 Then
  Begin
    Try
      LstrNumDoc := objLisFre.FieldByName('NUMDOC').AsString;
      LstrCodFor := objLisFre.FieldByName('CODTRA').AsString;
      LstrSerie := objLisFre.FieldByName('SERIE_').AsString;
      LstrDtaDoc := objLisFre.FieldByName('DTAENT').AsString;
      LstrPrevis := objLisFre.fGetPrevis;

      if LstrPrevis = 'S' then
        exit;

      pCriarFormularios(TFrmManipulaContasPagarPrevisaoNao, frmManipulaContasPagarPrevisaoNao) ;
      frmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao(
        LstrNumDoc, LstrCodFor, LstrSerie, StrToDate(LstrDtaDoc)
      ) ;

      if frmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim then
        frmManipulaContasPagarPrevisaoNao.showModal ;

    Finally
      FreeAndNil(frmManipulaContasPagarPrevisaoNao) ;
    End;
  End;
end;

procedure TfrmEntFreConGrid.btnIncluirClick(Sender: TObject);
begin
  inherited;

  objLisFre.pAlteraConhecimento(True, arrDuplicata);
end;

procedure TfrmEntFreConGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If objLisFre.blnVarNot And (Not blnGravou) And (objLisFre.RecordCount > 0) Then
  Begin

    If Not fPergunta('Os conhecimentos ainda não foram gravados. Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

end;

procedure TfrmEntFreConGrid.FormCreate(Sender: TObject);
begin
  inherited;

  blnGravou := False;
end;

procedure TfrmEntFreConGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnAlterar.Click;

  End;
end;

procedure TfrmEntFreConGrid.FormShow(Sender: TObject);
begin
  inherited;

  cxgFretesView.DataController.DataSource := objLisFre.dtsSource;

  btnGravar.Visible := objLisFre.blnVarNot;

  If objLisFre.blnVarNot Then
    btnSair.Caption := 'Cancela';
end;

end.
