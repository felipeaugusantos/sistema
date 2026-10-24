unit untPafCadIniECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPafCadIniECF = class(TfrmPai)
    edtNumSer: TEditFocus;
    edtValGT: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    lblSugest: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnExtrairDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExtrairDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    strNomArq: String;
  public
    { Public declarations }
  end;

var
  frmPafCadIniECF: TfrmPafCadIniECF;

implementation

uses untFuncoes, untFiscal, untPafGerais, untFuncoesSimples, untFuncoesHash;

{$R *.dfm}

procedure TfrmPafCadIniECF.btnConfirmaDadosClick(Sender: TObject);
  Var
    strLinha: AnsiString;
    arqText: TextFile;
begin
  inherited;
  
  strLinha := fCriptografa(AnsiString(edtNumSer.Text + '|' + edtValGT.Text));
  AssignFile(arqText, strNomArq);
  Rewrite(arqText);
  WriteLn(arqText, strLinha);
  Flush(arqText);
  CloseFile(arqText);

  Close;
end;

procedure TfrmPafCadIniECF.FormCreate(Sender: TObject);
  Var
    strNumSer: String;
    fltValGT: Double;
begin
  inherited;

  strNomArq := fCfgSis('DIRINI') + '\DADOS.ECF';

  If (Not FileExists(strNomArq)) And (Assigned(VS_objFiscal)) Then
  Begin
    edtNumSer.Text := Trim(VS_objFiscal.fNumeroSerie);
    edtValGT.Text := FloatToStrF(VS_objFiscal.fGrandeTotal, ffNumber, 12, 2);
    lblSugest.Visible := True;
    Exit;
  End;

  fRetornaNumSerGT(strNumSer, fltValGT);
  edtNumSer.Text := strNumSer;
  edtValGT.Text := FloatToStrF(fltValGT, ffNumber, 12, 2);
end;

procedure TfrmPafCadIniECF.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumSer);
end;

procedure TfrmPafCadIniECF.btnExtrairDadosClick(Sender: TObject);
begin
  inherited;
  If Assigned(VS_objFiscal) Then
  Begin
    edtNumSer.Text := Trim(VS_objFiscal.fNumeroSerie);
    edtValGT.Text := FloatToStrF(VS_objFiscal.fGrandeTotal, ffNumber, 12, 2);
    lblSugest.Visible := True;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Verifique se a impressora e o PAF-ECF estão configurados corretamente.',
      ['&Ok']);
  End;
end;

end.
