unit untCadKilGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadKilGeraArquivos = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure pGeracaoKillingAccess;
    procedure pGeracaoKillingFireBird;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadKilGeraArquivos: TfrmCadKilGeraArquivos;

implementation

uses untKillingDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadKilGeraArquivos.btnConfirmaGeracaoClick(Sender: TObject);
begin
  pGeracaoKillingAccess;  //Geracao Antiga
  pGeracaoKillingFireBird; //Geracao Nova
end;

procedure TfrmCadKilGeraArquivos.pGeracaoKillingAccess;
{  Var
    killing: TKillingDinamica;}
begin
{  Try
    btnConfirmaGeracao.Enabled := False;
    killing := TKillingDinamica.Create(Self);
    killing.RegistraAcao := pRegistrAcao;
    killing.RegistraProgresso := pRegistraProgresso;

    If killing.fProcessarArquivos Then
      fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK'])
    else
      fMensagem('', 'Não foi possível processar os arquivos!', ['OK']);

    btnConfirmaGeracao.Enabled := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadAdvGeraArquivo.btnConfirmaGeracaoClick]');
    End;
  End;

  FreeAndNil(killing);}
end;

procedure TfrmCadKilGeraArquivos.pGeracaoKillingFireBird;
  Var
    Killing: TKillingDinamicaFireBird;
begin
  Try
    Try
      btnConfirmaGeracao.Enabled := False;
      Killing := TKillingDinamicaFireBird.Create(Self);
      Killing.RegistraAcao := pRegistrAcao;
      Killing.RegistraProgresso := pRegistraProgresso;

      If Killing.fProcessarArquivos Then
        fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);

      btnConfirmaGeracao.Enabled := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadAdvGeraArquivo.btnConfirmaGeracaoClick]');
      End;
    End;
  Finally
    FreeAndNil(Killing);
  End;
end;

end.
