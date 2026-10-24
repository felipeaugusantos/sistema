unit untEnvInterfaceAnalitica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.Mask, MaskEditFocus, Uni, Vcl.ComCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEnvInterfaceAnalitica = class(TfrmPai)
    pnlGrid: TPanel;
    pnlFiltros: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1TableView1: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnEnviar: TBitBtnLocked;
    cxGridCitel1TableView1Column1: TcxGridDBColumn;
    cxGridCitel1TableView1Column2: TcxGridDBColumn;
    pgbProgresso: TProgressBar;
    dtsDados: TDataSource;
    procedure btnEnviarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryEnvNps : TUniQuery;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untNetpointsInterfaceAnalitica, untFuncoesSimples;

{ TfrmEnvInterfaceAnalitica }

procedure TfrmEnvInterfaceAnalitica.btnEnviarClick(Sender: TObject);
  Var
    objIntAna : TNetpointsInterfaceAnalitica;
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If (StrToDate(mskDtaFin.Text) >= VS_Date) Then
  Begin
    If fMensagem('AVISO', 'Se o movimento do dia ainda não foi encerrado o arquivo do dia: ' + FormatDateTime('dd/mm/yyyy', VS_Date) + ' pode estar incompleto, enviar mesmo assim?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  pnlInfo.Caption := 'Aguarde... Enviando.';
  qryEnvNps.Close;
  dtsDados.DataSet := qryEnvNps;
  objIntAna := TNetpointsInterfaceAnalitica.Create(Self);
  Try
    objIntAna.fEnviar(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), fnOw(), qryEnvNps, pgbProgresso);
  Finally
    FreeAndNil(objIntAna);
    pnlInfo.Caption := '';
  End;

  fMensagem('AVISO','Processo de envio concluído!', ['&OK']);
end;

procedure TfrmEnvInterfaceAnalitica.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmEnvInterfaceAnalitica.FormCreate(Sender: TObject);
begin
  inherited;
  qryEnvNps := fCriaQuery(Self);
end;

procedure TfrmEnvInterfaceAnalitica.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryEnvNps);
  inherited;
end;

function TfrmEnvInterfaceAnalitica.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser menor que a data final!',['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
