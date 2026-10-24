unit untGarantiaAltPrecosEnvFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, strUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmGarantiaAltPrecosEnvFornecedor = class(TfrmPaiConfirma)
    dtsItens: TDataSource;
    Panel1: TPanel;
    dbgItens: TDBGridCitel;
    lbl1: TLabel;
    edtTotGer: TDBEditFocus;
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cdsItensAfterInsert(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensColEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    intDecUni: Integer;
    procedure pDefinirSeAlterouValor;
    { Private declarations }
  public
    stlIncAlteracao: TStrings;
    blnAlterouValor: Boolean;
    { Public declarations }
    cdsItens: TUniClientDataSet;
  end;

var
  frmGarantiaAltPrecosEnvFornecedor: TfrmGarantiaAltPrecosEnvFornecedor;

implementation

uses untFuncoesSimples, System.UITypes;

{$R *.dfm}

procedure TfrmGarantiaAltPrecosEnvFornecedor.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.cdsItensAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.cdsItensBeforePost(DataSet: TDataSet);

  function fValidaValor: Boolean;
  begin
//    Result := DataSet.FieldByName('ITE_UNITAR').AsFloat >= DataSet.FieldByName('ITE_PRECUS').AsFloat;
//    If Not Result Then
//      pMensagemOk('O preço unitário não pode ser menor que o preço de custo do produto!');
    Result := DataSet.FieldByName('ITE_UNITAR').AsFloat > 0;
    If Not Result Then
      pMensagemOk('O preço unitário deve ser maior que zero!');
  end;

  procedure pCalculaValor;
  begin
    If DataSet.State = dsEdit Then
    Begin
      DataSet.FieldByName('ITE_UNIDIG').AsFloat := DataSet.FieldByName('ITE_UNITAR').AsFloat;
      DataSet.FieldByName('ITE_TOTITE').AsFloat := DataSet.FieldByName('ITE_UNITAR').AsFloat * DataSet.FieldByName('ITE_QTDITE').AsFloat;
    End;
  end;

begin
  inherited;
  pCalculaValor;

  If Not fValidaValor Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
  pDefinirSeAlterouValor;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.dbgItensColEnter(Sender: TObject);
begin
  inherited;
  cdsItens.FieldByName('ITE_UNITAR').FocusControl;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.dbgItensDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not Assigned(cdsItens) Then
    Exit;

  If Not cdsItens.IsEmpty Then
  Begin
    If (dbgItens.Canvas.Brush.Color <> clHighlight) Then
    Begin
      If (cdsItens.RecNo Mod 2 = 0) Then
        dbgItens.Canvas.Brush.Color := clMoneyGreen
      Else
        dbgItens.Canvas.Brush.Color := clWhite;
      dbgItens.Canvas.Font.Color := clBlack;
    End;

    dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;

end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.pDefinirSeAlterouValor;
Var
  fldUnitario: TField;
  lstrAutInc: String;
begin
  fldUnitario := cdsItens.FieldByName('ITE_UNITAR');
  if cdsItens.State = DsEdit then
  begin
    if fldUnitario.NewValue <> fldUnitario.OldValue then
    begin
      if Assigned(stlIncAlteracao) then
      begin
        lstrAutInc := cdsItens.FieldByName('ITE_INCDEV').AsString;
        if stlIncAlteracao.IndexOf(lstrAutInc) = -1 Then
          stlIncAlteracao.Add(lstrAutInc);
      end;

      if Not blnAlterouValor Then
        blnAlterouValor := True;
    end;
  end;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsItens.BeforePost  := nil;
  cdsItens.AfterInsert := nil;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  blnAlterouValor := False;
  intDecUni := fCfgSis('DECUNI', varInteger);
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_F10: Begin
              Key := 0;    
              btnConfirma.Click;
            End;

    VK_RETURN: If ((ActiveControl) = dbgItens) Then
               Begin
                 If (cdsItens.State = dsEdit) Then
                   cdsItens.Post

                 Else If (cdsItens.State = dsBrowse) Then
                   cdsItens.Edit;
               End;

    VK_DELETE: If ((ActiveControl) = dbgItens) Then
               Begin
                 If (cdsItens.State = dsBrowse) Or (ssCtrl In Shift) Then
                   Key := 0;
               End;    
  End;
end;

procedure TfrmGarantiaAltPrecosEnvFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet := cdsItens;

  cdsItens.BeforePost  := cdsItensBeforePost;
  cdsItens.AfterInsert := cdsItensAfterInsert;
  cdsItens.First;

  TFloatField(cdsItens.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsItens.FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsItens.FieldByName('ITE_UNITAR')).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsItens.FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  dbgItensColEnter(nil);
end;




end.
