unit untUtilMenuPAFNFCeIdentificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni;

type
  TfrmUtilMenuPAFNFCeIdentificacao = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    mmoIdentificacao: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
  end;

//var
  //frmUtilMenuPAFNFCeIdentificacao: TfrmUtilMenuPAFNFCeIdentificacao;

implementation

uses
  untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmUtilMenuPAFNFCeIdentificacao }


procedure TfrmUtilMenuPAFNFCeIdentificacao.FormShow(Sender: TObject);
var
  qryAux : TUniQuery;
  strEndereco : String;
begin
  inherited;
qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM SFTINF');
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      strEndereco := 'End.: '+ qryAux.FieldByName('SFT_ENDERE').AsString + ', '+
                               qryAux.FieldByName('SFT_ENDNUM').AsString + ', '+
                               qryAux.FieldByName('SFT_ENDCPL').AsString + sLineBreak +
                     '          Bairro: '+ qryAux.FieldByName('SFT_BAIRRO').AsString + sLineBreak +
                     '          '+ qryAux.FieldByName('SFT_NOMCID').AsString + ' / ' +
                               qryAux.FieldByName('SFT_ESTADO').AsString + ' - CEP: '+
                               qryAux.FieldByName('SFT_C_E_P_').AsString;

      mmoIdentificacao.Lines.Clear;
      mmoIdentificacao.Lines.Add('Cnpj: '+ qryAux.FieldByName('SFT_C_G_C_').AsString);
      mmoIdentificacao.Lines.Add('IES: '+ qryAux.FieldByName('SFT_I_E_S_').AsString);
      mmoIdentificacao.Lines.Add('Ins. Municipal: '+ qryAux.FieldByName('SFT_INSMUN').AsString);
      mmoIdentificacao.Lines.Add('Razão Social: '+ qryAux.FieldByName('SFT_RAZSOC').AsString);
      mmoIdentificacao.Lines.Add(strEndereco);
      mmoIdentificacao.Lines.Add('Telefone: '+ qryAux.FieldByName('SFT_FONE01').AsString + ' / ' +
                                               qryAux.FieldByName('SFT_FONE02').AsString);
      mmoIdentificacao.Lines.Add('Contatos: '+ qryAux.FieldByName('SFT_CONT01').AsString);
      mmoIdentificacao.Lines.Add('                  '+ qryAux.FieldByName('SFT_CONT02').AsString);
      mmoIdentificacao.Lines.Add(' ');

      mmoIdentificacao.Lines.Add('Nome Comercial: '+ qryAux.FieldByName('SFT_NOMEXE').AsString);
      mmoIdentificacao.Lines.Add('Versão: '+ qryAux.FieldByName('SFT_VEREXE').AsString);
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

end.

