unit untConfiguraDadosGiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  untCalcGirFrame, untCalcGirMesesFrame, BitBtnLockedIncrem, Vcl.DBCtrls, Data.DB,
  untSalvaDadosCfgGiro;

type
  TfrmConfiguraDadosGiro = class(TfrmPaiConfirma)
    pnlSugestao: TPanel;
    pnlCalculo: TPanel;
    dtsCFGSIS: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objSalvaDados: TSalvaDadosCfgGiro;

    Function fCamposOk: Boolean;

    procedure pCriaFrameCalculoSugestao;
    procedure pCriaFrameCalculoMeses;

  public
    { Public declarations }

    fraCalcGirFrame: TfraCalcGirFrame;
    fraCalcGirMesesFrame: TfraCalcGirMesesFrame;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmConfiguraDadosGiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

     If fCamposOk Then
     Begin

       If objSalvaDados.fAtualizaDados Then
         objSalvaDados.fSalvaDados(VS_strCodEmp);

     End Else
       Action := caNone;

  End;
end;

procedure TfrmConfiguraDadosGiro.FormCreate(Sender: TObject);
begin
  pCriaFrameCalculoSugestao;
  pCriaFrameCalculoMeses;

  inherited;

  Self.ClientHeight := pnlBotoes.Height + pnlStatus.Height + pnlSugestao.Height + pnlCalculo.Height+5;

  objSalvaDados := TSalvaDadosCfgGiro.Create(Self);
end;

procedure TfrmConfiguraDadosGiro.FormShow(Sender: TObject);
begin
  inherited;

  objSalvaDados.fCarregaDados(VS_strCodEmp, Self.Name);
end;

procedure TfrmConfiguraDadosGiro.pCriaFrameCalculoSugestao;
Begin
  fraCalcGirFrame          := TfraCalcGirFrame.Create(Self);
  pnlSugestao.ClientHeight := fraCalcGirFrame.Height + 6;

  fraCalcGirFrame.Parent   := pnlSugestao;
  fraCalcGirFrame.Top      := 3;
  fraCalcGirFrame.Left     := 7;
  fraCalcGirFrame.TabOrder := 0;

  Self.ClientWidth  := fraCalcGirFrame.Width + 14;

  fraCalcGirFrame.pCarregaEmpresas;
End;

procedure TfrmConfiguraDadosGiro.pCriaFrameCalculoMeses;
Begin
  fraCalcGirMesesFrame          := TfraCalcGirMesesFrame.Create(Self);
  pnlCalculo.ClientHeight       := fraCalcGirMesesFrame.Height + 6;

  fraCalcGirMesesFrame.frmPai   := Self;
  fraCalcGirMesesFrame.Parent   := pnlCalculo;
  fraCalcGirMesesFrame.Top      := 2;
  fraCalcGirMesesFrame.Left     := 7;
  fraCalcGirMesesFrame.TabOrder := 0;

  fraCalcGirMesesFrame.pInicializaDados;
End;

Function TfrmConfiguraDadosGiro.fCamposOk: Boolean;
begin
  With fraCalcGirMesesFrame Do
  Begin

    Result := False;

    If Not objNiveis.fValidaDados Then
      Exit;

    If blnSolBasGir And (fContaSelecaoBaseGiro = 0) Then
    Begin
      fMensagem('','Você deve selecionar um mês de Base para Cálculo do Giro!',['&O K']);
      pSetFocus(lstBasGir);

      If lstBasGir.Items.Count > 0 Then
        lstBasGir.Selected[0] := True;

      Exit;
    End;

    If chkInfMes.Checked Then
    Begin
      If Not cdsMeses.fValidaMeses(fRetNroMeses) Then
      Begin
        pMensagemOk('Selecione os meses desejados para o giro!');

        If Self.Showing Then
          lblSelMesClick(lblSelMes);
        Exit;
      End;
    End;

    Result := True;

  End;
end;


end.
