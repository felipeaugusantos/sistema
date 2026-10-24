unit untEntRetencaoNotaServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, untCadImpostosNFS,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untConstantes, Data.DB, Datasnap.DBClient, UniClientDataSet;

type
  TfrmEntRetencaoNotaServico = class(TfrmPaiConfirma)
    pnlContainer: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    function fCalculaRetencao: Boolean;
   protected
     function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
     procedure pDecidePost(DataSet: TDataSet; ModalResult: Integer);


  public
    fraCadImpostosNFS: TfraCadImpostosNFS;
    class function fChamaEntRetencoesNotaServico(cdsLivroFiscal: TUniClientDataSet;
                                                  strNumDoc: String;
                                                  strEntSai: String;
                                                  strTip_Fc: String;
                                                  strForCli: String;
                                                  strNomFor: String;
                                                  strCodEmp: String;
                                                  strSerie : String;
                                                  dtaDtaEnt: TDate;
                                                  strEspDoc: String;
                                                  dtaDtaDoc: TDate;
                                                  strClaFis: String): TfrmEntRetencaoNotaServico;

    { Public declarations }
  End;



implementation

uses
  untFuncoesSimples, untFuncoes;

{$R *.dfm}





{ TfrmEntRetencaoNotaServico }

class function TfrmEntRetencaoNotaServico.fChamaEntRetencoesNotaServico(cdsLivroFiscal: TUniClientDataSet;
                                                  strNumDoc: String;
                                                  strEntSai: String;
                                                  strTip_Fc: String;
                                                  strForCli: String;
                                                  strNomFor: String;
                                                  strCodEmp: String;
                                                  strSerie : String;
                                                  dtaDtaEnt: TDate;
                                                  strEspDoc: String;
                                                  dtaDtaDoc: TDate;
                                                  strClaFis: String): TfrmEntRetencaoNotaServico;

begin
  pCriarFormularios(TfrmEntRetencaoNotaServico, Result);
  Result.fraCadImpostosNFS := TfraCadImpostosNFS.fCriaFrameImpostos(Result, Result.pnlContainer);
  Result.fraCadImpostosNFS.frmPai := Result;
  Result.fraCadImpostosNFS.btnConfirmar := Result.btnConfirma;
  Result.fraCadImpostosNFS.blnEntradaMercadoria:= True;
  Result.fraCadImpostosNFS.strNumDoc := strNumDoc;
  Result.fraCadImpostosNFS.strEntSai := strEntSai;
  Result.fraCadImpostosNFS.strTip_Fc := strTip_Fc;
  Result.fraCadImpostosNFS.strForCli := strForCli;
  Result.fraCadImpostosNFS.strCodEmp := strCodEmp;
  Result.fraCadImpostosNFS.strSerie  := strSerie;
  Result.fraCadImpostosNFS.dtaDtaEnt := dtaDtaEnt;
  Result.fraCadImpostosNFS.strEspDoc := strEspDoc;
  Result.fraCadImpostosNFS.dtaDtaDoc := dtaDtaDoc;
  Result.fraCadImpostosNFS.strClaFis := strClaFis;
  Result.fraCadImpostosNFS.strNomFor := strNomFor;
  Result.fraCadImpostosNFS.pInicializaDados(cdsLivroFiscal);

  pSetFocus(Result.fraCadImpostosNFS.dbeVREPIS);
  Result.fraCadImpostosNFS.grpIss.Visible := False;

  If Result.fCalculaRetencao Then
    Result.fraCadImpostosNFS.pCarregarRetencoes();
  Result.ClientHeight := Result.pnlBotoes.Height + 20;
  If Result.fraCadImpostosNFS.grpIss.Visible Then
    Result.ClientHeight := Result.ClientHeight + Result.fraCadImpostosNFS.grpIss.Height;
  If Result.fraCadImpostosNFS.grpRent.Visible Then
    Result.ClientHeight := Result.ClientHeight + Result.fraCadImpostosNFS.grpRent.Height;
  If Result.fraCadImpostosNFS.grpRetencaoDados.Visible Then
  Begin
    Result.ClientHeight := Result.ClientHeight + Result.fraCadImpostosNFS.grpRetencaoDados.Height;
    pSetFocus(Result.fraCadImpostosNFS.cmbTipImp);
  End
  Else
  Begin
    Result.fraCadIMpostosNFS.grdImpostosTableView1.OnDblClick := Nil;
  End;
  If Result.fraCadImpostosNFS.grbRetencoes.Visible THen
    Result.ClientHeight := Result.ClientHeight + Result.fraCadImpostosNFS.grbRetencoes.Height;
  Result.ShowModal;

  Result.pDecidePost(cdsLivroFiscal, Result.ModalResult);

end;


procedure TfrmEntRetencaoNotaServico.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  {}
end;

procedure TfrmEntRetencaoNotaServico.FormShow(Sender: TObject);
begin
  inherited;
  pSetaEventos(Self);
end;

function TfrmEntRetencaoNotaServico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := fraCadImpostosNFS.fValidaCampos(Sender, blnBuscaPorChave);
end;

procedure TfrmEntRetencaoNotaServico.pDecidePost(DataSet: TDataSet; ModalResult: Integer);
begin
  If ModalResult = 1 Then
  Begin
    If DataSet.State = dsEdit Then
      DataSet.Post;
  End
  Else
  Begin
    If DataSet.state = dsEdit Then
      DataSet.Cancel;
  End;
end;

procedure TfrmEntRetencaoNotaServico.btnConfirmaClick(Sender: TObject);
begin
  If Not btnConfirma.Enabled Then
    Exit;
  inherited;

end;

function TfrmEntRetencaoNotaServico.fCalculaRetencao: Boolean;
Begin
  Result := False;
  If (Not fraCadImpostosNFS.grbRetencoes.Visible) Then
    Exit(True);
  If (fraCadImpostosNFS.fRetTotalImpostos = 0) Then
    Exit(True);
End;

end.
