unit untFatMensagemExpedicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, uniClientDataSet,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, untZClient;

type
  TfrmFatMensagemExpedicao = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label5: TLabel;
    edtMensagemExpedicao1: TEditFocus;
    edtMensagemExpedicao2: TEditFocus;
    edtMensagemExpedicao3: TEditFocus;
    edtMensagemExpedicao4: TEditFocus;
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    pnlDocumentos: TPanel;
    lblCocumentos: TLabel;
    cbbDocumentos: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbDocumentosChange(Sender: TObject);
  private
    { Private declarations }
    FCdsExpedicao : TUniClientDataSet;
    procedure pAtualizaBancoDeDados;
    procedure pAtualizaClient;
    procedure pCarregaMensagens;
    procedure pFiltraDocumentos;
  public
    { Public declarations }
    stlPedidos: TStringList;
    blnExpedicaoItens: Boolean;
    strFiltroOriginal: string;
    property CdsExpedicao : TUniClientDataSet read FCdsExpedicao write FCdsExpedicao;
  end;

implementation

uses Uni, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMensagemExpedicao.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFatMensagemExpedicao.btnConfirmaDadosClick(Sender: TObject);
begin
  pAtualizaClient;
  pAtualizaBancoDeDados;
  Close;
end;

procedure TfrmFatMensagemExpedicao.cbbDocumentosChange(Sender: TObject);
begin
  inherited;
  FCdsExpedicao.Locate('DOCUME', cbbDocumentos.Items[cbbDocumentos.ItemIndex], []);
  pCarregaMensagens;
end;

procedure TfrmFatMensagemExpedicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if blnExpedicaoItens then
  begin
    FCdsExpedicao.Filtered := False;
    FCdsExpedicao.Filter := strFiltroOriginal;
    FCdsExpedicao.Filtered := True;
  end;

  If Assigned(stlPedidos) Then
    FreeAndNil(stlPedidos);

end;

procedure TfrmFatMensagemExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  stlPedidos := TStringList.Create;
  blnExpedicaoItens := False;
end;

procedure TfrmFatMensagemExpedicao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirmaDados.Click;
end;

procedure TfrmFatMensagemExpedicao.FormShow(Sender: TObject);
begin
  pnlDocumentos.Visible := blnExpedicaoItens;
  pFiltraDocumentos;
  pCarregaMensagens;
  pSetFocus(edtMensagemExpedicao1);
end;

procedure TfrmFatMensagemExpedicao.pAtualizaBancoDeDados;
var
  SQuery : TUniQuery;
  arrConfigSql : array of string;
begin
  SQuery := fCriaQuery(Nil);

  if FCdsExpedicao.FieldByName('ESPDOC').AsString <> 'PD' then
    arrConfigSql := ['MOVGER', 'GER']
  else
    arrConfigSql := ['FATGOR', 'FGO'];

  try
    Try
      fStartTransaction;

      SQuery.SQL.Text := ' UPDATE '+arrConfigSql[0]+' SET          '+
                         arrConfigSql[1]+'_MENEXP       = :MENEXP, '+
                         arrConfigSql[1]+'_MENEX2       = :MENEX2, '+
                         arrConfigSql[1]+'_MENEX3       = :MENEX3, '+
                         arrConfigSql[1]+'_MENEX4       = :MENEX4  '+
                         ' WHERE AUTOINCREM = :AUTINC  ';
      SQuery.ParamByName('MENEXP').AsString := FCdsExpedicao.FieldByName('MENEXP').AsString;
      SQuery.ParamByName('MENEX2').AsString := FCdsExpedicao.FieldByName('MENEX2').AsString;
      SQuery.ParamByName('MENEX3').AsString := FCdsExpedicao.FieldByName('MENEX3').AsString;
      SQuery.ParamByName('MENEX4').AsString := FCdsExpedicao.FieldByName('MENEX4').AsString;
      SQuery.ParamByName('AUTINC').AsString := FCdsExpedicao.FieldByName('AUTINC').AsString;
      SQuery.ExecSQL;

      fCommit;
    Finally
      FreeAndNil(SQuery);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmFatMensagemExpedicao.pAtualizaBancoDeDados]');
    End;
  end;
end;

procedure TfrmFatMensagemExpedicao.pAtualizaClient;
begin
  FCdsExpedicao.Edit;
  FCdsExpedicao.FieldByName('MENEXP').AsString := edtMensagemExpedicao1.Text;
  FCdsExpedicao.FieldByName('MENEX2').AsString := edtMensagemExpedicao2.Text;
  FCdsExpedicao.FieldByName('MENEX3').AsString := edtMensagemExpedicao3.Text;
  FCdsExpedicao.FieldByName('MENEX4').AsString := edtMensagemExpedicao4.Text;
  FCdsExpedicao.Post;
end;

procedure TfrmFatMensagemExpedicao.pCarregaMensagens;
begin
  edtMensagemExpedicao1.Text := FCdsExpedicao.FieldByName('MENEXP').AsString;
  edtMensagemExpedicao2.Text := FCdsExpedicao.FieldByName('MENEX2').AsString;
  edtMensagemExpedicao3.Text := FCdsExpedicao.FieldByName('MENEX3').AsString;
  edtMensagemExpedicao4.Text := FCdsExpedicao.FieldByName('MENEX4').AsString;
end;

procedure TfrmFatMensagemExpedicao.pFiltraDocumentos;
var
  intContador: integer;
  strAutIncDocs: string;
begin
  if not blnExpedicaoItens then
    Exit;

  strAutIncDocs := EmptyStr;

  strFiltroOriginal := FCdsExpedicao.Filter;

  for intContador := 0 to stlPedidos.Count - 1 do
  begin
    pIncrementaListaStr(stlPedidos[intContador], strAutIncDocs, True, False);
  end;

  FCdsExpedicao.Filtered := False;

  if not fEmptyStr(FCdsExpedicao.Filter) then
    FCdsExpedicao.Filter := FCdsExpedicao.Filter + ' AND ';

  FCdsExpedicao.Filter := FCdsExpedicao.Filter + ' AUTINC IN('+strAutIncDocs+') ';
  FCdsExpedicao.Filtered := True;

  FCdsExpedicao.First;
  cbbDocumentos.Clear;

  while not FCdsExpedicao.Eof do
  begin
    cbbDocumentos.Items.Add(FCdsExpedicao.FieldByName('DOCUME').AsString);
    FCdsExpedicao.Next;
  end;

  cbbDocumentos.ItemIndex := 0;
  FCdsExpedicao.Locate('DOCUME', cbbDocumentos.Items[cbbDocumentos.ItemIndex], []);
end;

end.

