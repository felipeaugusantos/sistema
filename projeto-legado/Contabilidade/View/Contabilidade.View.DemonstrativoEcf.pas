unit Contabilidade.View.DemonstrativoEcf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, EditFocus, Vcl.DBCtrls, DBMemoFocus, untFuncoesSimples,
  MemDS, DBAccess, Uni;

type
  TfrmDemonstrativoEcf = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbmDescricao: TDBMemoFocus;
    edtTipCta: TEditFocus;
    edtFormato: TEditFocus;
    dbmOrient: TDBMemoFocus;
    btnPesquisa: TBitBtnLocked;
    edtContaRef: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    dbgDemEcf: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    dtsDemEcf: TDataSource;
    cbEcf: TcxComboBox;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtsDemEcfStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDemEcfDblClick(Sender: TObject);
    procedure dbgDemEcfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    strSQL: string;
    procedure pCarregaRegistrosECF(const ATipo: string);
    procedure pLimpaCbECF;
    function fValidaCamposInformados:Boolean ;
  public
    strCodRef: string;
    qryTabela: TUniQuery;
  end;

implementation

uses
  Contabilidade.Classes.TEcf;

{$R *.dfm}

procedure TfrmDemonstrativoEcf.pCarregaRegistrosECF(const ATipo: string);
var
  qryEcf : TUniQuery ;
  info : TInfoECF ;
begin
  qryEcf := fCriaQuery() ;
  try
    qryEcf.Close ;
    qryEcf.SQL.Clear ;
    qryEcf.SQL.Add('SELECT REG_BLCECF, REG_REGECF FROM ECFREG WHERE REG_TIPREG = :TIPREG ORDER BY REG_BLCECF, REG_REGECF ') ;
    qryEcf.ParamByName('TIPREG').AsString := ATipo ;
    qryEcf.Open ;
    cbEcf.Properties.Items.Clear ;
    qryEcf.First ;
    while not qryEcf.Eof do
    begin
      info := TInfoECF.Create ;
      info.blc := qryEcf.FieldByName('REG_BLCECF').AsString ;
      info.reg := qryEcf.FieldByName('REG_REGECF').AsString ;

      cbEcf.Properties.Items.AddObject(qryEcf.FieldByName('REG_BLCECF').AsString+qryEcf.FieldByName('REG_REGECF').AsString, info);

      qryEcf.Next ;
    end;

  finally
    FreeAndNil(qryEcf) ;
  end;
end;

procedure TfrmDemonstrativoEcf.pLimpaCbECF;
var
  intCnt : integer ;
begin
  for intCnt := 0 to cbEcf.Properties.Items.Count-1 do
  begin
    TInfoECF(cbEcf.Properties.Items.Objects[intCnt]).Free ;
  end;
end;

procedure TfrmDemonstrativoEcf.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if not btnConfirma.Enabled then
    Exit;

  strCodRef := qryTabela.FieldByName('DEM_CODDEM').AsString;
  Self.Close;
end;

procedure TfrmDemonstrativoEcf.btnPesquisaClick(Sender: TObject);
begin
  if not fValidaCamposInformados then
  begin
    fMensagem('ATENÇÃO!', 'É necessário preencher pelo menos um campo para efetuar a pesquisa!', ['&OK']);
    pSetFocus(edtContaRef);
    Exit;
  end;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add(strSQL);
  qryTabela.SQL.Add('WHERE TRUE ');

  if (not fEmptyStr(edtContaRef.Text)) then
  begin
    qryTabela.SQL.Add('  AND DEM_CODDEM = :CODDEM ');
    qryTabela.ParamByName('CODDEM').AsString := edtContaRef.Text;
  end;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) then
  begin
    qryTabela.SQL.Add('  AND DEM_DTAINI = :DTAINI ');
    qryTabela.ParamByName('DTAINI').AsDate := mskDtaIni.Date;
  end;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
  begin
    qryTabela.SQL.Add('  AND DEM_DTAFIN = :DTAFIN ');
    qryTabela.ParamByName('DTAFIN').AsDate := mskDtaFin.Date;
  end;

  if (not fEmptyStr(edtTipCta.Text)) then
  begin
    qryTabela.SQL.Add('  AND DEM_TIPDEM = :TIPDEM ');
    qryTabela.ParamByName('TIPDEM').AsString := edtTipCta.Text;
  end;

  if (not fEmptyStr(edtFormato.Text)) then
  begin
    qryTabela.SQL.Add('  AND DEM_FMTDEM = :FMTDEM ');
    qryTabela.ParamByName('FMTDEM').AsString := edtFormato.Text;
  end;

  if cbEcf.ItemIndex <> -1 then
  begin
    qryTabela.SQL.Add('  AND DEM_BLCECF = :BLCECF AND DEM_REGECF = :REGECF ');
    qryTabela.ParamByName('BLCECF').AsString := TInfoECF(cbEcf.Properties.Items.Objects[cbEcf.ItemIndex]).blc;
    qryTabela.ParamByName('REGECF').AsString := TInfoECF(cbEcf.Properties.Items.Objects[cbEcf.ItemIndex]).reg;
  end;

  try
    qryTabela.Open;
    pSetFocus(btnConfirma);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnPesquisaClick]');
    End;
  End;
end;

procedure TfrmDemonstrativoEcf.dbgDemEcfDblClick(Sender: TObject);
begin
  inherited;
  btnConfirmaClick(nil);
end;

procedure TfrmDemonstrativoEcf.dbgDemEcfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN then
    btnConfirmaClick(nil);
end;

procedure TfrmDemonstrativoEcf.dtsDemEcfStateChange(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := (qryTabela.Active) and (not qryTabela.IsEmpty);
end;

procedure TfrmDemonstrativoEcf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.Close;
  FreeAndNil(qryTabela);
  pLimpaCbECF;
end;

procedure TfrmDemonstrativoEcf.FormCreate(Sender: TObject);
begin
  inherited;
  strSQL := 'SELECT * FROM ECFDEM ';
  qryTabela         := fCriaQuery();
  dtsDemEcf.DataSet := qryTabela;
  strCodRef := '';
end;

procedure TfrmDemonstrativoEcf.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaRegistrosECF('D') ;
  pSetFocus(edtContaRef);
end;

function TfrmDemonstrativoEcf.fValidaCamposInformados: Boolean;
begin
  result := True ;
  if not fEmptyStr(edtContaRef.Text) then
  begin
    exit ;
  end;
  if not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
  begin
    exit ;
  end;
  if not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
  begin
    exit ;
  end;
  if not fEmptyStr(edtTipCta.Text) then
  begin
    exit ;
  end;
  if not fEmptyStr(edtFormato.Text) then
  begin
    exit ;
  end;
  if cbEcf.ItemIndex <> -1 then
  begin
    exit ;
  end;
  result := False ;
end;

end.
