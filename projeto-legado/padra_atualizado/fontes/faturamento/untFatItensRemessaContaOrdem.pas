unit untFatItensRemessaContaOrdem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncFat, Vcl.ComCtrls, UniClientDataSet,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmFatItensRemessaContaOrdem = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    dtsDados: TDataSource;
    dbgDados: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure dbgDadosKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDadosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FcdsDados : TUniClientDataSet;

    procedure pCarregaValoresRemessa; overload;
    procedure pBeforePost(DataSet: TDataSet);

  public
    { Public declarations }
    objVenda : TFatVenda;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure pGravarDadosCdsVenda;

    class procedure pCarregaValoresRemessa(const ADataSet: TDataSet); overload;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

constructor TfrmFatItensRemessaContaOrdem.Create(AOwner: TComponent);
begin
  inherited;
  FcdsDados := TUniClientDataSet.Create(GetParentForm(Self));
end;

procedure TfrmFatItensRemessaContaOrdem.dbgDadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = chr(VK_RETURN)) Then
  Begin
    Key := #0;
    If (dtsDados.DataSet.State = dsEdit) Then
      TUniClientDataSet(dtsDados.DataSet).ApplyUpdates(-1);
  End;
end;

procedure TfrmFatItensRemessaContaOrdem.dbgDadosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DOWN) Or
     (Key = VK_TAB) Then
  Begin
    If (fEmptyStr(dtsDados.DataSet.FieldByName('ITE_CODITE').AsString)) And
       (dtsDados.DataSet.State = dsInsert) Then
    Begin
      Key := 0;
      TUniClientDataSet(dtsDados.DataSet).Cancel;
      dtsDados.DataSet.Last;
    End;
  End;
end;

destructor TfrmFatItensRemessaContaOrdem.Destroy;
begin
  FreeAndNil(FcdsDados);
  inherited;
end;

procedure TfrmFatItensRemessaContaOrdem.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnCancelaDados.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatItensRemessaContaOrdem.FormShow(Sender: TObject);
begin
  inherited;
  pCloneDataSet(FcdsDados, cdsVenda, True);
  dtsDados.DataSet := FcdsDados;

  pCarregaValoresRemessa;

  dtsDados.DataSet.BeforePost := pBeforePost;

  pSetFocus(dbgDados);
end;

procedure TfrmFatItensRemessaContaOrdem.pBeforePost(DataSet: TDataSet);
begin
  dtsDados.DataSet.FieldByName('ITE_TOTREM').AsFloat := dtsDados.DataSet.FieldByName('ITE_UNIREM').AsFloat
                                                      * dtsDados.DataSet.FieldByName('ITE_QTDITE').AsFloat;
end;

procedure TfrmFatItensRemessaContaOrdem.pCarregaValoresRemessa;
begin
  Try
    dtsDados.DataSet.DisableControls;
    pCarregaValoresRemessa(dtsDados.DataSet);
  Finally
    dtsDados.DataSet.EnableControls;
  End;
end;

class procedure TfrmFatItensRemessaContaOrdem.pCarregaValoresRemessa(
  const ADataSet: TDataSet);
begin
  ADataSet.First;
  While Not ADataSet.Eof Do
  Begin
    If ADataSet.FieldByName('ITE_UNIREM').AsFloat = 0 Then
    Begin
      ADataSet.Edit;
      ADataSet.FieldByName('ITE_UNIREM').AsFloat := ADataSet.FieldByName('ITE_UNITAR').AsFloat;
      ADataSet.FieldByName('ITE_TOTREM').AsFloat := ADataSet.FieldByName('ITE_TOTITE').AsFloat;
      ADataSet.Post;
    End;

    ADataSet.Next;
  End;

  ADataSet.First;
end;

procedure TfrmFatItensRemessaContaOrdem.pGravarDadosCdsVenda;
begin
  Try
    dtsDados.DataSet.DisableControls;
    cdsVenda.DisableControls;

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      If dtsDados.DataSet.Locate('AUTOINCREM', cdsVenda.FieldByName('AUTOINCREM').AsString, []) Then
      Begin
        cdsVenda.Edit;
        cdsVenda.FieldByName('ITE_UNIREM').AsFloat := dtsDados.DataSet.FieldByName('ITE_UNIREM').AsFloat;
        cdsVenda.FieldByName('ITE_TOTREM').AsFloat := dtsDados.DataSet.FieldByName('ITE_TOTREM').AsFloat;
        cdsVenda.Post;
      End;

      cdsVenda.Next;
    End;

    cdsVenda.First;
  Finally
    cdsVenda.EnableControls;
    dtsDados.DataSet.EnableControls;
  End;
end;

end.
