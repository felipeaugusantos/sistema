unit untTelDadosEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, BitBtnLockedIncrem, MaskUtils;

type
  TfrmTelDadosEntrega = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlGeral: TPanel;
    Label2: TLabel;
    edtEndEnt: TEditFocus;
    Label3: TLabel;
    edtBaiEnt: TEditFocus;
    edtCidEnt: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtEstEnt: TEditFocus;
    edtCepEnt: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    edtTelEnt: TEditFocus;
    edtConEnt: TEditFocus;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaDadosCliente;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesGenerica, untFuncoesSimples;

{$R *.dfm}

{ TfrmTelDadosEntrega }

procedure TfrmTelDadosEntrega.pCarregaDadosCliente;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT                                                                                        ');
  qryAux.SQL.Add('  CLI_NOMCLI,                                                                                 ');
  qryAux.SQL.Add('  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_ENDERE, ETC_ENDENT) CLI_ENDENT,               ');
  qryAux.SQL.Add('  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_BAIRRO, ETC_BAIENT) CLI_BAIENT,               ');
  qryAux.SQL.Add('  CID_NOMCID AS CLI_CIDENT,                                                                   ');
  qryAux.SQL.Add('  CID_ESTADO AS CLI_ESTENT,                                                                   ');
  qryAux.SQL.Add('  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_C_E_P_, ETC_CEPENT) CLI_CEPENT,               ');
  qryAux.SQL.Add('  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_FONE01, ETC_TELENT) CLI_TELENT,               ');
  qryAux.SQL.Add('  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_CONTAT, ETC_CONENT) CLI_CONENT                ');
  qryAux.SQL.Add('FROM                                                                                          ');
  qryAux.SQL.Add('  CADCLI                                                                                      ');

  qryAux.SQL.Add('  LEFT JOIN ENTCLI ON ETC_CODCLI = CLI_CODCLI AND ');
  qryAux.SQL.Add('                      ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI) ');

  qryAux.SQL.Add('JOIN CADCID ON CID_CODCID = IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, CLI_CODCID, ETC_CIDENT) ');
  qryAux.SQL.Add('WHERE                                                                                         ');
  qryAux.SQL.Add('  CLI_CODCLI = :CODCLI                                                                        ');

  qryAux.ParamByName('CODCLI').AsString := edtCodCli.Text;
  qryAux.Open;

  edtNomCli.Text := qryAux.FieldByName('CLI_NOMCLI').AsString;
  edtEndEnt.Text := qryAux.FieldByName('CLI_ENDENT').AsString;
  edtBaiEnt.Text := qryAux.FieldByName('CLI_BAIENT').AsString;
  edtCidEnt.Text := qryAux.FieldByName('CLI_CIDENT').AsString;
  edtEstEnt.Text := qryAux.FieldByName('CLI_ESTENT').AsString;
  edtCepEnt.Text := FormatMaskText('99999-999;0;_', qryAux.FieldByName('CLI_CEPENT').AsString);
  edtTelEnt.Text := fFormataFone(qryAux.FieldByName('CLI_TELENT').AsString);
  edtConEnt.Text := qryAux.FieldByName('CLI_CONENT').AsString;

  qryAux.Close;
  FreeAndNil(qryAux);

end;

procedure TfrmTelDadosEntrega.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDadosCliente;
end;

end.
