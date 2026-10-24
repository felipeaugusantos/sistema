unit untListaEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, cxGraphics, cxControls, untExcel,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, untGeraExcel,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni, untFuncoesSimples, untTEnvioEmail,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmListaEmail = class(TfrmPaiSimples)
    dsConsulta: TDataSource;
    cdsConsulta: TUniClientDataSet;
    cdsConsultarazaoSocial: TStringField;
    cdsConsultaendereco: TStringField;
    cdsConsultaCliente: TStringField;
    cxDados: TcxGridCitel;
    cxDadosDBTableView: TcxGridDBTableViewCitel;
    cxDadosDBTableViewColumn1: TcxGridDBColumn;
    cxDadosDBTableViewColumn2: TcxGridDBColumn;
    cxDadosDBTableViewColumn3: TcxGridDBColumn;
    cxDadosLevel1: TcxGridLevel;
    btnGeraExcel: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGeraExcelClick(Sender: TObject);
  private
    { Private declarations }
    blnMensagem: Boolean;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  public
    { Public declarations }

   class procedure pAtualizaValorConsulta(strLista: TArrStrEmails; blnMensagem: Boolean);

  end;

implementation

{$R *.dfm}

{ TfrmListaEmail }

procedure TfrmListaEmail.btnGeraExcelClick(Sender: TObject);
begin
  If TGeraExcel.fGerarRelatorio(cxDadosDBTableView, 'Erros de Envio de E-mail', OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmListaEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End
  Else
  If (Key = VK_Escape) Then
  Begin
    Close;
  End;
end;

procedure TfrmListaEmail.FormShow(Sender: TObject);
begin
  inherited;
  If blnMensagem Then
    untFuncoesSimples.fMensagem('AVISO!', 'Falha somente no envio para os endereços de e-mail a seguir. Domínio informado não encontrado!', ['&OK']);
end;

procedure TfrmListaEmail.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
//
end;

class procedure TfrmListaEmail.pAtualizaValorConsulta(strLista: TArrStrEmails; blnMensagem: Boolean);
var
  qryBusca: TUniQuery;
  iIndice: integer;
  strListaSemCliente: TArrStrEmails;
  frmListaEmail: TfrmListaEmail;
begin
  qryBusca := fCriaQuery;

  pCriarFormularios(TfrmListaEmail, frmListaEmail);
  frmListaEmail.cdsConsulta.CreateDataSet;
  frmListaEmail.blnMensagem := blnMensagem;

  For iIndice := 0 to high(strLista) Do
  Begin
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI');
    qryBusca.SQL.Add('WHERE REPLACE(CLI_EMAIL_, ";", "") = :EMAIL');
    qryBusca.SQL.Add('ORDER BY CLI_NOMCLI');
    qryBusca.ParamByName('EMAIL').AsString  := strLista[iIndice].endereco;
    qryBusca.Open;

    If Not qryBusca.isEmpty Then
    Begin
      qryBusca.First;
      While not qryBusca.eof Do
      Begin
        frmListaEmail.cdsConsulta.Append;
        frmListaEmail.cdsConsultaEndereco.AsString    := strLista[iIndice].endereco;
        frmListaEmail.cdsConsultaCliente.AsString     := qryBusca.FieldByName('CLI_CODCLI').AsString;
        frmListaEmail.cdsConsultaRazaoSocial.AsString := qryBusca.FieldByName('CLI_NOMCLI').AsString;
        frmListaEmail.cdsConsulta.Post;
        qryBusca.Next;
      End;
    End
    Else
    Begin
      setLength(strListaSemCliente, length(strListaSemCliente)+1);
      strListaSemCliente[high(strListaSemCliente)].endereco := strLista[iIndice].endereco;
    End;
  End;
  If length(strListaSemCliente) > 0 Then
  Begin
    For iIndice := 0 to high(strListaSemCliente) Do
    Begin
      frmListaEmail.cdsConsulta.Append;
      frmListaEmail.cdsConsultaEndereco.AsString    := strListaSemCliente[iIndice].endereco;
      frmListaEmail.cdsConsultaCliente.AsString     := '';
      frmListaEmail.cdsConsultaRazaoSocial.AsString := '';
      frmListaEmail.cdsConsulta.Post;
    End;
  End;
  If Not frmListaEmail.cdsConsulta.isEmpty Then
  Begin
    frmListaEmail.cdsConsulta.First;
    frmListaEmail.ShowModal;
  End;
  FreeAndNil(frmListaEmail.cdsConsulta);
  FreeAndNil(frmListaEmail);

  FreeAndNil(qryBusca);
end;

end.
