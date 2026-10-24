unit untFatMostraLitragGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, Grids, DBGridCitel, DBGrids, Menus, ComCtrls,
  Buttons, ExtCtrls, AppEvnts, DB, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Uni, UniClientDataSet, untFuncoesSimples;

type
  TfrmFatMostraLitragGrupo = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    dbeEstoque: TDBGridCitel;
    Panel1: TPanel;
    Label2: TLabel;
    lblSaldo: TLabel;
    dtsLitrag: TDataSource;
    btnFechar: TBitBtnLocked;
    pgbStatus: TProgressBar;
    rdgLinGru: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    lblTotal: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rdgLinGruClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cdsResultado: TUniClientDataSet;

    procedure pMostraLitragemGrupo;
  public
    { Public declarations }
    cdsItensPedido: TUniClientDataSet;
    blnUsarGiro: Boolean;
    intOrdem: Integer;
  end;

var
  frmFatMostraLitragGrupo: TfrmFatMostraLitragGrupo;

implementation

{$R *.dfm}

Uses
  StrUtils;


procedure TfrmFatMostraLitragGrupo.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  pMostraLitragemGrupo;

end;

procedure TfrmFatMostraLitragGrupo.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraLitragGrupo.FormCreate(Sender: TObject);
begin
  inherited;

  cdsResultado := TUniClientDataSet.Create(Self);

  With cdsResultado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODGRU';
    DataType := ftString;
    Size := 6;
  End;

  With cdsResultado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESGRU';
    DataType := ftString;
    Size := 70;
  End;

  With cdsResultado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_LITROS';
    DataType := ftFloat;
  End;

  with cdsResultado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TOTITE';
    DataType := ftFloat;
  End;

  cdsResultado.CreateDataSet;
  cdsResultado.IndexFieldNames := 'ITE_CODGRU';

end;

procedure TfrmFatMostraLitragGrupo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraLitragGrupo.pMostraLitragemGrupo;
  Var
    strLinGru: String;
begin
  pgbStatus.Visible := True;

  Screen.Cursor := crHourGlass;
  pnlInfo.Caption := 'Aguarde, calculando litros/quilos...';

  cdsItensPedido.DisableControls;
  cdsItensPedido.First;

  cdsResultado.EmptyDataSet;

  pgbStatus.Max := cdsItensPedido.RecordCount;

  While (Not cdsItensPedido.Eof) Do
  Begin

    If rdgLinGru.ItemIndex = 1 Then
      strLinGru := cdsItensPedido.FieldByName('ITE_CODGRU').AsString
    Else
      strLinGru := LeftStr(cdsItensPedido.FieldByName('ITE_CODGRU').AsString, 3) + '000';

    If Not cdsResultado.FindKey([strLinGru]) Then
    Begin
      cdsResultado.Append;
      cdsResultado.FieldByName('ITE_LITROS').Value    := 0;

      cdsResultado.FieldByName('ITE_CODGRU').AsString := strLinGru;
      cdsResultado.FieldByName('ITE_DESGRU').AsString := fRetNomeLinhaGrupo(strLinGru);

    End Else
    Begin
      cdsResultado.Edit;
    End;
    cdsResultado.FieldByName('ITE_TOTITE').Value    := cdsResultado.FieldByName('ITE_TOTITE').AsFloat + cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;
    cdsResultado.FieldByName('ITE_LITROS').Value    := cdsResultado.FieldByName('ITE_LITROS').AsFloat + cdsItensPedido.FieldByName('ITE_LITROS').AsFloat;
    cdsResultado.Post;

    cdsItensPedido.Next;

    pgbStatus.StepBy(1);
    Application.ProcessMessages;
  End;

  TFloatField(cdsResultado.FieldByName('ITE_LITROS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsResultado.FieldByName('ITE_TOTITE')).DisplayFormat := '#,##0.00';

  cdsItensPedido.EnableControls;

  pgbStatus.Visible := False;
  pnlInfo.Caption := '';
  Screen.Cursor := crDefault;
  dtsLitrag.DataSet := cdsResultado;
end;

procedure TfrmFatMostraLitragGrupo.rdgLinGruClick(Sender: TObject);
begin
  inherited;

  Case rdgLinGru.ItemIndex Of
    0: dbeEstoque.Columns[0].Title.Caption := 'Linha';
    1: dbeEstoque.Columns[0].Title.Caption := 'Grupo';
  End;

  pMostraLitragemGrupo;
end;

end.
