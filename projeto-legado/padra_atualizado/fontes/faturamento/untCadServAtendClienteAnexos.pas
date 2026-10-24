unit untCadServAtendClienteAnexos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Uni, untFuncoesSimples;

type
  TfrmCadServAtendClienteAnexos = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgArquivos: TDBGridCitel;
    opdCarrega: TOpenDialog;
    btnAnexar: TBitBtnLocked;
    dtsAnexos: TDataSource;
    svdBaixa: TSaveDialog;
    procedure btnAnexarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgArquivosDblClick(Sender: TObject);
  private

  public
    strSeqSac: string;
    qryAnexos: TUniQuery;
  end;

implementation

{$R *.dfm}

procedure TfrmCadServAtendClienteAnexos.btnAnexarClick(Sender: TObject);
var
  blnCarregou: Boolean;
  strNomeAquvio: string;
begin
  inherited;
  blnCarregou := opdCarrega.Execute();
  if (not blnCarregou) or (fEmptyStr(opdCarrega.FileName)) then
  begin
    fMensagem('Atenção!', 'Arquivo não Selecionado!', ['&Ok']);
    Exit;
  end;

  if (not FileExists(opdCarrega.FileName)) then
  begin
    fMensagem('Atenção!', 'Arquivo não Existe!', ['&Ok']);
    Exit;
  end;

  strNomeAquvio := ExtractFileName(opdCarrega.FileName);

//  fStartTransaction();
  try
    if qryAnexos.Locate('SAC_NOMARQ', strNomeAquvio, []) then
      qryAnexos.Edit
    else
    begin
      qryAnexos.Insert;
      qryAnexos.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ARQSAC', VS_strCodEmp);
      qryAnexos.FieldByName('SAC_SEQSAC').AsString   := strSeqSac;
      qryAnexos.FieldByName('SAC_NOMARQ').AsString   := strNomeAquvio;
    end;

    TBlobField(qryAnexos.FieldByName('SAC_ARQUIV')).LoadFromFile(opdCarrega.FileName);
    qryAnexos.FieldByName('SAC_DTAANX').AsDateTime := VS_Date;
    qryAnexos.FieldByName('SAC_HRAANX').AsDateTime := fTime();
    qryAnexos.Post;
//    fCommit();
  except
    on E: Exception do
    begin
//      fRollBack();
      pMensagensErro(E.Message, '[TfrmCadServAtendClienteAnexos.btnAnexarClick]');
    end;
  end;
end;

procedure TfrmCadServAtendClienteAnexos.dbgArquivosDblClick(Sender: TObject);
var
  blnSalvar: Boolean;
begin
  inherited;

  if qryAnexos.IsEmpty then
    Exit;

  svdBaixa.FileName := qryAnexos.FieldByName('SAC_NOMARQ').AsString;
  blnSalvar := svdBaixa.Execute();

  if (blnSalvar) and (not fEmptyStr(svdBaixa.FileName)) then
  begin
    if FileExists(svdBaixa.FileName) then
      DeleteFile(svdBaixa.FileName);

    TBlobField(qryAnexos.FieldByName('SAC_ARQUIV')).SaveToFile(svdBaixa.FileName);
  end;
end;

procedure TfrmCadServAtendClienteAnexos.FormShow(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(strSeqSac) then
    Close;

  dtsAnexos.DataSet := qryAnexos;

  pSetFocus(dbgArquivos);
end;

end.
