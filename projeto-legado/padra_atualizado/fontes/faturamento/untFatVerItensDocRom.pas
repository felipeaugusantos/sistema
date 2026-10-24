unit untFatVerItensDocRom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, UniClientDataSet;

type
  TfrmFatVerItensDocRom = class(TfrmPai)
    dtsVolumes: TDataSource;
    cdsVolumes: TUniClientDataSet;
    cdsVolumesNUMVOL: TIntegerField;
    grbItens: TGroupBox;
    dbgItens: TDBGridCitel;
    grbVolumes: TGroupBox;
    dbgVolumes: TDBGridCitel;
    cdsVolumesBIPADO: TStringField;
    Splitter: TSplitter;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgVolumesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgVolumesTitleClick(Column: TColumn);
  private

    FEhRomaneioSimplificado  : Boolean;
    FVolumesBipados          : TUniClientDataSet;
    FQuantidadeDeVolumes     : Integer;
    FDocumentoJahSelecionado : Boolean;

    procedure pCarregarVolumes;

  public
    blnItensPedidoExpedicao : Boolean;
    blnClientesExpedicao    : Boolean;
    procedure pConfiguraGridItensPedido;
    procedure pConfiguraGridClientesExpedicao;

    property blnEhRomaneioSimplificado  : Boolean           read FEhRomaneioSimplificado  write FEhRomaneioSimplificado;
    property cdsVolumesBipados          : TUniClientDataSet read FVolumesBipados          write FVolumesBipados;
    property intQuantidadeDeVolumes     : Integer           read FQuantidadeDeVolumes     write FQuantidadeDeVolumes;
    property blnDocumentoJahSelecionado : Boolean           read FDocumentoJahSelecionado write FDocumentoJahSelecionado;

  end;

var
  frmFatVerItensDocRom: TfrmFatVerItensDocRom;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatVerItensDocRom.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmFatVerItensDocRom.dbgVolumesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  inherited;
  If Not cdsVolumes.Active Then
    Exit;

  dbgVolumes.Canvas.Font.Color := IIF(cdsVolumes.FieldByName('BIPADO').AsString = 'Sim', clBlue, clRed);
  dbgVolumes.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatVerItensDocRom.dbgVolumesTitleClick(Column: TColumn);
begin
  inherited;
  cdsVolumes.IndexFieldNames := Column.FieldName;
end;

procedure TfrmFatVerItensDocRom.FormCreate(Sender: TObject);
begin
  inherited;

  blnItensPedidoExpedicao := False;
  blnClientesExpedicao    := False;

  FEhRomaneioSimplificado  := False;
  FVolumesBipados          := Nil;
  FQuantidadeDeVolumes     := 0;
  FDocumentoJahSelecionado := False;

end;

procedure TfrmFatVerItensDocRom.FormShow(Sender: TObject);
begin
  inherited;

  grbVolumes.Visible := Assigned(FVolumesBipados);

  If Assigned(FVolumesBipados) Then
    pCarregarVolumes;

  if (not blnItensPedidoExpedicao) And (not blnClientesExpedicao) then
    dbgItens.Columns[3].Visible := (fCfgSis('EXITUR', varBoolean));

  pSetFocus(dbgItens);
end;

procedure TfrmFatVerItensDocRom.pConfiguraGridItensPedido;
begin
  Self.Width := 882;

  dbgItens.Columns.Clear;
  dbgItens.Columns.Add.FieldName := 'CODITE';
  dbgItens.Columns[0].Title.Caption := 'Código';
  dbgItens.Columns[0].Width := 45;

  dbgItens.Columns.Add.FieldName := 'DESITE';
  dbgItens.Columns[1].Title.Caption := 'Produto';
  dbgItens.Columns[1].Width := 409;

  dbgItens.Columns.Add.FieldName := 'UNIDAD';
  dbgItens.Columns[2].Alignment := taCenter;
  dbgItens.Columns[2].Title.Caption := 'UN';
  dbgItens.Columns[2].Title.Alignment := taCenter;
  dbgItens.Columns[2].Width := 25;

  dbgItens.Columns.Add.FieldName := 'NUMLOT';
  dbgItens.Columns[3].Title.Caption := 'Lote';
  dbgItens.Columns[3].Width := 129;

  dbgItens.Columns.Add.FieldName := 'QTDITE';
  dbgItens.Columns[4].Alignment := taRightJustify;
  dbgItens.Columns[4].Title.Caption := 'Qtde Original';
  dbgItens.Columns[4].Title.Alignment := taRightJustify;
  dbgItens.Columns[4].Width := 110;

  dbgItens.Columns.Add.FieldName := 'QTDFAT';
  dbgItens.Columns[5].Alignment := taRightJustify;
  dbgItens.Columns[5].Title.Caption := 'Qtde Pend. Faturar';
  dbgItens.Columns[5].Title.Alignment := taRightJustify;
  dbgItens.Columns[5].Width := 110;

  If fCfgSis('EXISEE', varBoolean) Then
  Begin
    dbgItens.Columns.Add.FieldName := 'SALDOS';
    dbgItens.Columns[6].Alignment := taRightJustify;
    dbgItens.Columns[6].Title.Caption := 'Estoque';
    dbgItens.Columns[6].Title.Alignment := taRightJustify;
    dbgItens.Columns[6].Width := 110;

    dbgItens.Columns[1].Width := 290;
  End;
end;


procedure TfrmFatVerItensDocRom.pCarregarVolumes;
var
  intVolumes : Integer;
begin

  grbVolumes.Visible := FEhRomaneioSimplificado;

  If Not (grbVolumes.Visible) Then
    Exit;

  If Not (FQuantidadeDeVolumes > 0) Then
    Exit;

  cdsVolumes.CreateDataSet;
  cdsVolumes.IndexFieldNames := 'NUMVOL';

  for intVolumes := 1 to FQuantidadeDeVolumes do
  begin
    cdsVolumes.Append;
    cdsVolumesNUMVOL.AsInteger := intVolumes;
    cdsVolumesBIPADO.AsString  := IIF(FVolumesBipados.Locate('NUMVOL', intVolumes, []) Or FDocumentoJahSelecionado, 'Sim', 'Não');
    cdsVolumes.Post;
  end;

  cdsVolumes.First;

end;

procedure TfrmFatVerItensDocRom.pConfiguraGridClientesExpedicao;
begin
  Self.Width := 597;

  frmFatVerItensDocRom.Caption := 'Valores Mínimos do(s) Cliente(s)';

  dbgItens.Columns.Clear;
  dbgItens.Columns.Add.FieldName := 'CLI_CODCLI';
  dbgItens.Columns[0].Title.Caption := 'Cliente';
  dbgItens.Columns[0].Width := 100;

  dbgItens.Columns.Add.FieldName := 'CLI_NOMCLI';
  dbgItens.Columns[1].Title.Caption := 'Nome Cliente';
  dbgItens.Columns[1].Width := 200;

  dbgItens.Columns.Add.FieldName := 'CLI_VLMINE';
  dbgItens.Columns[2].Title.Caption := 'Vlr Mínimo NF Entrega';
  dbgItens.Columns[2].Width := 113;

  dbgItens.Columns.Add.FieldName := 'CLI_VLMINR';
  dbgItens.Columns[3].Title.Caption := 'Vlr Mínimo NF Retira';
  dbgItens.Columns[3].Width := 113;
end;


end.

