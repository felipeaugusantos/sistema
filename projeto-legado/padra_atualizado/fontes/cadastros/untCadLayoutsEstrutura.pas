unit untCadLayoutsEstrutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, uni, Datasnap.DBClient, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TMoveLay = (mlUp, mlDown);
  TfrmCadLayoutsEstrutura = class(TfrmPaiConfirma)
    Label25: TLabel;
    edtNomLay: TEditFocus;
    btnAdd: TBitBtnLocked;
    cxgLayEst: TcxGridCitel;
    cxgLayEstTV: TcxGridDBTableViewCitel;
    cxgLayEstLAYOUT: TcxGridDBColumn;
    cxgLayEstLvl1: TcxGridLevel;
    edtCodLay: TEditFocus;
    btnUp: TBitBtnLocked;
    btnDown: TBitBtnLocked;
    cxgLayEstTVORDEM: TcxGridDBColumn;
    dtsLayEst: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodLayKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure cxgLayEstTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pMoveLayout(enuMoveLay: TMoveLay);
    procedure pDeletaLayout;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    { Private declarations }
  public
    cdsLayEst   : TUniClientDataSet;
    strCodIte   : String;
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, TypesRel;

function TfrmCadLayoutsEstrutura.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtCodLay) then
  begin
    if blnBuscaPorChave then
    begin
      if fEmptyStr(edtCodLay.Text) then
      begin
        fMensagem('','Selecione o Layout!', ['&OK']);
        Result := False;
      end
      else
      begin

        edtNomLay.Text := fRetornaDescricaoLayoutEtq(edtCodLay.Text);

        If fEmptyStr(edtNomLay.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Layout de etiqueta para ordem de produção inválido!',['&OK']);
          Result := False;
        End;

      end;
    end;

  end;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadLayoutsEstrutura.btnAddClick(Sender: TObject);
var
  intLastOrdem : Integer;
begin
  inherited;

  If fValidaCampos(edtCodLay,True) Then
  Begin
    if cdsLayEst.IsEmpty then
      intLastOrdem := 0
    else
    begin
      cdsLayEst.Last;
      intLastOrdem := cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger;
    end;

    If Not cdsLayEst.Locate('LAY_CODLAY', edtCodLay.Text, []) Then
      cdsLayEst.Append
    Else
      cdsLayEst.Edit;

    cdsLayEst.FieldByName('LAY_CODITE').AsString  := strCodIte;
    cdsLayEst.FieldByName('LAY_CODLAY').AsString  := edtCodLay.Text;
    cdsLayEst.FieldByName('LAY_DESCRI').AsString  := edtNomLay.Text;
    cdsLayEst.FieldByName('LAY_CODEMP').AsString  := VS_strCodEmp;
    if cdsLayEst.State in [dsInsert] then
      cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger := intLastOrdem+1;

    cdsLayEst.Post;

    edtCodLay.Clear;
    edtNomLay.Clear;
    pSetFocus(edtCodLay);
  End;

end;

procedure TfrmCadLayoutsEstrutura.btnConfirmaClick(Sender: TObject);
begin
  if cdsLayEst.IsEmpty then
  begin
    pMensagemOk('É necessário cadastrar ao menos um layout!');
    exit;
  end
  else
  begin
    close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmCadLayoutsEstrutura.btnDownClick(Sender: TObject);
begin
  inherited;
  if cdsLayEst.RecNo < cdsLayEst.RecordCount then
  begin
    cdsLayEst.DisableControls;
    pMoveLayout(mlDown);
    cdsLayEst.EnableControls;
  end;
end;

procedure TfrmCadLayoutsEstrutura.btnUpClick(Sender: TObject);
begin
  inherited;

  if cdsLayEst.RecNo > 1 then
  begin
    cdsLayEst.DisableControls;
    pMoveLayout(mlUp);
    cdsLayEst.EnableControls;
  end;
end;

procedure TfrmCadLayoutsEstrutura.cxgLayEstTVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_DELETE: If fMensagem('', 'Deseja apagar o Layout?', ['&Sim', '&Não'],2)=1 Then
                 pDeletaLayout;
  end;
end;

procedure TfrmCadLayoutsEstrutura.pDeletaLayout;
begin
 if cdsLayEst.RecNo = cdsLayEst.RecordCount then
   cdsLayEst.Delete
 else
 begin
    cdsLayEst.Delete;
    while not cdsLayEst.Eof do
    begin
      cdsLayEst.Edit;
      cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger := cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger - 1;
      cdsLayEst.Post;

      cdsLayEst.Next;
    end;
 end;

end;

procedure TfrmCadLayoutsEstrutura.pMoveLayout(enuMoveLay : TMoveLay);
var
  intOrdemOld : Integer;
  intOrdemNew : Integer;
  strCodLay   : String;
  strFilter   : String;
  blnFilter   : boolean;
begin
  intOrdemOld  := cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger;
  strCodLay := cdsLayEst.FieldByName('LAY_CODLAY').AsString;

  Case enuMoveLay of
    mlUp   : intOrdemNew := intOrdemOld -1;
    mlDown : intOrdemNew := intOrdemOld +1;
    else
      intOrdemNew := 0;
  end;

  cdsLayEst.Edit;
  cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger := intOrdemNew;
  cdsLayEst.Post;

  blnFilter          := cdsLayEst.Filtered;
  strFilter          := cdsLayEst.Filter;
  cdsLayEst.Filtered := False;
  cdsLayEst.Filter   := 'LAY_CODLAY <> '+ QuotedStr(strCodLay) + ' AND LAY_ORDEM_ = '+ IntToStr(intOrdemNew);
  cdsLayEst.Filtered := True;

  if not cdsLayEst.isEmpty then
  begin
    cdsLayEst.Edit;
    cdsLayEst.FieldByName('LAY_ORDEM_').AsInteger := intOrdemOld;
    cdsLayEst.Post;
  end;

  cdsLayEst.Filter   := strFilter;
  cdsLayEst.Filtered := blnFilter;

  cdsLayEst.Locate('LAY_CODLAY', strCodLay, []);

end;

procedure TfrmCadLayoutsEstrutura.edtCodLayKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayout(Self, edtCodLay, edtNomLay, Nil,'J',Key, arrSel, True, IntToStr(ARR_TIPO_LAYOUT[tpeOrdPro])) Then
  Begin
    If fValidaCampos(edtCodLay, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadLayoutsEstrutura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F10 : btnConfirma.Click;
    VK_F1  : btnUp.Click;
    VK_F2  : btnDown.Click;
  end;
end;

procedure TfrmCadLayoutsEstrutura.FormShow(Sender: TObject);
begin
  inherited;
  dtsLayEst.DataSet := cdsLayEst;
  if cdsLayEst.IsEmpty then
  begin
    edtCodLay.Text := fCampoTabela('LAY_CODLAY','LAYETI',['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'],[ARR_TIPO_LAYOUT[tpeOrdPro], 'S', VS_strCodEmp]);
    if edtCodLay.Text <> '' then
    begin
      edtNomLay.Text := fRetornaDescricaoLayoutEtq(edtCodLay.Text);
      pSetFocus(edtCodLay);
    end;
  end;
end;

end.
