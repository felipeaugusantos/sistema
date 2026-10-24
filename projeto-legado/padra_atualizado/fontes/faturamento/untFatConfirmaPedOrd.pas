unit untFatConfirmaPedOrd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untTypesSistema, untConsultas,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxButtonEdit, Uni, untFuncoesSimples;

type
  TfrmFatConfirmaPedOrc = class(TfrmPaiConfirma)
    cxgDadostv: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    cdsDados: TUniClientDataSet;
    dsDados: TDataSource;
    pnlRodape: TPanel;
    lblRodape: TLabel;
    btnLibera: TBitBtnLocked;
    cxgDadosNUMDOC: TcxGridDBColumn;
    cxgDadosCODEMP: TcxGridDBColumn;
    cxgDadosCODCLI: TcxGridDBColumn;
    cxgDadosNOMCLI: TcxGridDBColumn;
    cxgDadosESPDOC: TcxGridDBColumn;
    cxgDadosCODVEN: TcxGridDBColumn;
    cxgDadosNOMVEN: TcxGridDBColumn;
    cxgDadosOBSERV: TcxGridDBColumn;
    cxgDadosCCLNOV: TcxGridDBColumn;
    cxgDadosNCLNOV: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgDadosCCLNOVPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddDocumento(Numero, Especie, CodigoEmpresa, CodigoVendedor,
      NomeVendedor, CodigoCliente, NomeCliente, CodigoClienteNovo, NomeClienteNovo: String; Observacao: String = '');
  end;

implementation

{$R *.dfm}

{ TfrmFatConfirmaPedOrc }

procedure TfrmFatConfirmaPedOrc.AddDocumento(Numero, Especie, CodigoEmpresa,
  CodigoVendedor, NomeVendedor, CodigoCliente, NomeCliente, CodigoClienteNovo, NomeClienteNovo: String;
  Observacao: String = '');
begin
  cdsDados.Append;
  cdsDados.FieldByName('NUMDOC').AsString := Numero;
  cdsDados.FieldByName('ESPDOC').AsString := Especie;
  cdsDados.FieldByName('CODEMP').AsString := CodigoEmpresa;
  cdsDados.FieldByName('CODVEN').AsString := CodigoVendedor;
  cdsDados.FieldByName('NOMVEN').AsString := NomeVendedor;
  cdsDados.FieldByName('CODCLI').AsString := CodigoCliente;
  cdsDados.FieldByName('NOMCLI').AsString := NomeCliente;
  cdsDados.FieldByName('OBSERV').AsString := Observacao;
  cdsDados.FieldByName('CCLNOV').AsString := CodigoClienteNovo;
  cdsDados.FieldByName('NCLNOV').AsString := NomeClienteNovo;
  cdsDados.Post;

  if not fEmptyStr(CodigoClienteNovo) then
  begin
    cxgDadosCCLNOV.Visible := True;
    cxgDadosNCLNOV.Visible := True;
  end;
end;

procedure TfrmFatConfirmaPedOrc.cxgDadosCCLNOVPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  qryCliente: TUniQuery;
  arrSel: TConsultasArray;
  chrKey: Char;
begin
  inherited;

  qryCliente := fCriaQuery(Self);
  try
    chrKey := '/';
    if fPesqCliente(conCliCompleta, Self, nil, nil, qryCliente, chrKey, arrSel) then
    begin
      if not fClienteConsumidor(qryCliente.FieldByName('CLI_NOMCLI').AsString) then
      begin
        cdsDados.Edit;
        cdsDados.FieldByName('CCLNOV').AsString := qryCliente.FieldByName('CLI_CODCLI').AsString;
        cdsDados.FieldByName('NCLNOV').AsString := fRetNomCliente(cdsDados.FieldByName('CCLNOV').AsString);
        cdsDados.Post;

        cxgDadosCCLNOV.Properties.Buttons[0].Caption := 'Alterar';
        cxgDadostv.ApplyBestFit;
      end
      else
        fMensagem('ATENÇÃO!', 'O cliente informado não pode ser um Cliente Consumidor!', ['&Ok']);
    end;
  finally
    FreeAndNil(qryCliente);
  end;

end;

procedure TfrmFatConfirmaPedOrc.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados.CreateDataSet;
end;

procedure TfrmFatConfirmaPedOrc.FormShow(Sender: TObject);
begin
  inherited;
  cxgDadostv.ApplyBestFit();
end;

end.
