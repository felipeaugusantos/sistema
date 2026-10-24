unit untOrdProIndustrialAjustaEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, strUtils,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untOrdProIndustrial, Datasnap.DBClient, uni,
  UniClientDataSet, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmOrdProIndustrialAjustaEmbalagem = class(TfrmPaiConfirma)
    cxgComposicaoLevel: TcxGridLevel;
    cxgComposicaoTableView: TcxGridDBTableViewCitel;
    cxgComposicao: TcxGridCitel;
    cxgComposicaoTableViewColumn1: TcxGridDBColumn;
    cxgComposicaoTableViewColumn2: TcxGridDBColumn;
    cxgComposicaoTableViewColumn3: TcxGridDBColumn;
    cdsDigitacao: TuniClientDataSet;
    cdsDigitacaoAUTINC: TStringField;
    cdsDigitacaoCODITE: TStringField;
    cdsDigitacaoQTDITE: TFloatField;
    cdsDigitacaoQTDUSA: TFloatField;
    cdsDigitacaoDESITE: TStringField;
    cdsDigitacaoITEFRA: TStringField;
    dtsDigitacao: TDataSource;
    cxgComposicaoTableViewIteFra: TcxGridDBColumn;
    procedure cxgComposicaoTableViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgComposicaoTableViewIteFraGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    Class Function fValidaFracionados(objOrdProducao : TOrdProIndustrial):Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmOrdProIndustrialAjustaEmbalagem }

procedure TfrmOrdProIndustrialAjustaEmbalagem.btnConfirmaClick(Sender: TObject);
begin
  cdsDigitacao.CheckBrowseMode;

  inherited;

end;

procedure TfrmOrdProIndustrialAjustaEmbalagem.cxgComposicaoTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := (Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxgComposicaoTableViewIteFra.Index] = 'N');
end;

procedure TfrmOrdProIndustrialAjustaEmbalagem.cxgComposicaoTableViewIteFraGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' Then
    AText := 'Sim'
  Else
    AText := 'Não';
end;

procedure TfrmOrdProIndustrialAjustaEmbalagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = MrOk Then
  Begin
    Try
      cdsDigitacao.DisableControls;
      cdsDigitacao.First;
      While Not cdsDigitacao.Eof Do
      Begin
        If (cdsDigitacao.FieldByName('ITEFRA').AsString = 'N') And (Frac(cdsDigitacao.FieldByName('QTDUSA').AsFloat) > 0) Then
        Begin
          Action := caNone;
          fMensagem('', 'Todos os itens não fracionados devem conter quantidade inteira!', ['&OK']);
          Break;
        End;

        cdsDigitacao.Next;
      End;

    Finally
      cdsDigitacao.EnableControls;
    End;
  End;
end;

procedure TfrmOrdProIndustrialAjustaEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDigitacao.Active := False;
  pSetaCodIte(cdsDigitacaoCODITE);
  cdsDigitacao.Active := True;
end;

class function TfrmOrdProIndustrialAjustaEmbalagem.fValidaFracionados(objOrdProducao: TOrdProIndustrial): Boolean;
  Var
    frmOrdProIndustrialAjustaEmbalagem: TfrmOrdProIndustrialAjustaEmbalagem;
begin
  pCriarFormularios(TfrmOrdProIndustrialAjustaEmbalagem, frmOrdProIndustrialAjustaEmbalagem);
  With frmOrdProIndustrialAjustaEmbalagem Do
  Begin

    objOrdProducao.cdsOrdCom.First;
    While Not objOrdProducao.cdsOrdCom.Eof Do
    Begin
      cdsDigitacao.Append;
      cdsDigitacaoAUTINC.AsString := objOrdProducao.cdsOrdCom.FieldByName('AUTOINCREM').AsString;
      cdsDigitacaoCODITE.AsString := objOrdProducao.cdsOrdCom.FieldByName('ODC_CODITE').AsString;
      cdsDigitacaoQTDITE.AsFloat  := objOrdProducao.cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat;
      cdsDigitacaoQTDUSA.AsFloat  := objOrdProducao.cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * objOrdProducao.FieldByName('ORD_QTDENV').AsFloat;
      cdsDigitacaoDESITE.AsString := fRetNomProduto(objOrdProducao.cdsOrdCom.FieldByName('ODC_CODITE').AsString);
      cdsDigitacaoITEFRA.AsString := IfThen(fUnidadeDoProdutoEhFracionaria(objOrdProducao.cdsOrdCom.FieldByName('ODC_CODITE').AsString), 'S', 'N');
      cdsDigitacao.Post;

      objOrdProducao.cdsOrdCom.Next;
    End;

    frmOrdProIndustrialAjustaEmbalagem.ShowModal;
    Result := (frmOrdProIndustrialAjustaEmbalagem.ModalResult = MrOK);

    If Result Then
    Begin
      cdsDigitacao.First;
      While not cdsDigitacao.Eof Do
      Begin
        If objOrdProducao.cdsOrdCom.Locate('AUTOINCREM', cdsDigitacaoAUTINC.Value, []) Then
        Begin
          objOrdProducao.cdsOrdCom.Edit;
          objOrdProducao.cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := cdsDigitacaoQTDUSA.Value;
          objOrdProducao.cdsOrdCom.Post;
        End;
        cdsDigitacao.Next;
      End;

    End;

  End;
  FreeAndNil(frmOrdProIndustrialAjustaEmbalagem);

end;

end.
