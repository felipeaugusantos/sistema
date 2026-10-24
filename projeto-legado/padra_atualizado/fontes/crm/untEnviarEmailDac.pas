unit untEnviarEmailDac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmEnviarEmailDac = class(TfrmPaiConfirma)
    Panel1: TPanel;
    edtNumAD: TEditFocus;
    lblNumAD: TLabel;
    Label1: TLabel;
    edtNumDev: TEditFocus;
    Label2: TLabel;
    edtSerie_: TEditFocus;
    Label3: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FCodCli: String;
    FNomCli: String;
    FEmaCli: String;
    strCodAde: String;
    strCodOpe: String;
    strNumDoc: String;
    fltTotGer: Double;

    procedure pConsultaDocumentos;
    procedure pLimpaVariaveis;
    procedure pEnviarEmail;

    function FExisteAd: Boolean;
    function FExisteDev: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function getCodCli: String;
    function getNomCli: String;
    function getEmaCli: String;

    procedure setCodCli(const Value: String);
    procedure setNomCli(const Value: String);
    procedure setEmaCli(const Value: String);
  public
    { Public declarations }
    property strCodCli: String Read getCodCli Write setCodCli;
    property strNomCli: String Read getNomCli Write setNomCli;
    property strEmaCli: String Read getEmaCli Write setEmaCli;

  end;


implementation

uses untFuncoesSimples, untConstantes, untFuncoesCRM, Data.DB, untTypesSistema;

{$R *.dfm}

{ TfrmEnviarEmailDac }

procedure TfrmEnviarEmailDac.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  if fVerificaCampos then
  Begin
    pConsultaDocumentos;
    if FExisteAd and FExisteDev then
      ModalResult := mrOK;
  End;
end;

function TfrmEnviarEmailDac.FExisteAd: Boolean;
var
  qryAd: TUniQuery;
begin
  Try
    Try

      qryAd := fCriaQuery(Self);

      with qryAd do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT GER_CODADE ');
        SQL.Add('   FROM ADEGER     ');
        SQL.Add('  INNER JOIN MOVOCO ON OCO_CODOCO = GER_CODOCO ');
        SQL.Add('                   AND OCO_CODEMP = GER_CODEMP ');
        SQL.Add('  WHERE GER_CODADE = :CODADE ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        SQL.Add('    AND OCO_CODCLI = :CODCLI ');
        ParamByName('CODADE').AsString := edtNumAD.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODCLI').AsString := FCodCli;        
        Open;

        Result := not IsEmpty;
      end;

    Except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[FExisteAd]');
      end;
    End;
  Finally
    FreeAndNil(qryAd);
  End;
end;

function TfrmEnviarEmailDac.FExisteDev: Boolean;
var
  qryDev: TUniQuery;
  strSQL: String;
begin
  Try
    Try

      qryDev := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + ' SELECT SUM(D.DET_TOTITE - D.DET_DESESP) AS TOTAL, G.GER_CODDIG ';
      strSQL := strSQL + '   FROM MOVGER G ';
      strSQL := strSQL + '  INNER JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND  ';
      strSQL := strSQL + '                          D.DET_ESPDOC = G.GER_ESPDOC AND  ';
      strSQL := strSQL + '                          D.DET_CODEMP = G.GER_CODEMP AND  ';
      strSQL := strSQL + '                          D.DET_CODCLI = G.GER_CODCLI AND  ';
      strSQL := strSQL + '                          D.DET_TIP_FC = G.GER_TIP_FC AND  ';
      strSQL := strSQL + '                          IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
      strSQL := strSQL + '  INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ';
      strSQL := strSQL + '  WHERE G.GER_NUMDOC = :NUMDOC  ';
      strSQL := strSQL + '    AND (G.GER_ESPDOC = "DV" OR G.GER_ORIDOC = "D")   ';
      strSQL := strSQL + '    AND G.GER_CODEMP = :CODEMP  ';
      strSQL := strSQL + '    AND G.GER_CODCLI = :CODCLI  ';
      strSQL := strSQL + '    AND G.GER_TIP_FC = "C"      ';
      strSQL := strSQL + '    AND IFNULL(G.GER_SERIE_, "") = :SERIE_  ';
      strSQL := strSQL + '    AND A.AUX_CODADE = :CODADE  ';
      strSQL := strSQL + '  GROUP BY G.GER_CODDIG         ';

      with qryDev do
      begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := edtNumDev.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp ;
        ParamByName('CODCLI').AsString := FCodCli;
        ParamByName('SERIE_').AsString := edtSerie_.Text;
        ParamByName('CODADE').AsString := edtNumAD.Text;
        Open;

        Result := not IsEmpty;

        if Result then
        begin
          fltTotGer := FieldByName('TOTAL').AsFloat;
          strCodOpe := FieldByName('GER_CODDIG').AsString;
        end;
      end;

    Except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[FExisteDev]');
      end;
    End;
  Finally
    FreeAndNil(qryDev);
  End;
end;

procedure TfrmEnviarEmailDac.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumAD);
end;

procedure TfrmEnviarEmailDac.FormCreate(Sender: TObject);
begin
  inherited;
  pLimpaVariaveis;
  edtNumDev.MaxLength := fTamDocCadRec;
  edtNumDev.TamCampo  := fTamDocCadRec;
end;

function TfrmEnviarEmailDac.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try  
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtNumAD) Then
      Begin
        If (fEmptyStr(edtNumAD.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Número da Autorização de Devolução deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtNumDev) Then
      Begin
        If (fEmptyStr(edtNumDev.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Número da Devolução deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtSerie_) Then
      Begin
        If (fEmptyStr(edtSerie_.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Série deve ser preenchida!', ['&Ok']);
          Result := False;
        End;
      End
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
			fMensagem('', E.Message, ['&Ok']);
      Result := False;
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadClientes.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmEnviarEmailDac.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmEnviarEmailDac.getEmaCli: String;
begin
  Result := FEmaCli;
end;

function TfrmEnviarEmailDac.getNomCli: String;
begin
  Result := FNomCli;
end;

procedure TfrmEnviarEmailDac.pConsultaDocumentos;
begin
  if FExisteAd and FExisteDev then
    pEnviarEmail
  else
    fMensagem('ATENÇÃO!', 'As informações referentes ao processo de devolução' + #13#10 +
                          'não foram encontradas !', ['&Ok']);
end;

procedure TfrmEnviarEmailDac.pEnviarEmail;
begin
  If fEnviaMensagemParaOperadorAD(edtNumAD.Text, strCodOpe, FCodCli, FNomCli) Then
    pEnviaEmailParaClienteInformandoDV(FCodCli, FNomCli, edtNumDev.Text, VS_Date,
      fltTotGer, strCodOpe, FEmaCli);
end;

procedure TfrmEnviarEmailDac.pLimpaVariaveis;
begin
  FCodCli := '';
  FNomCli := '';
  FEmaCli := '';
  strCodAde := '';
  strCodOpe := '';
  strNumDoc := '';
  fltTotGer := 0;
end;

procedure TfrmEnviarEmailDac.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TfrmEnviarEmailDac.setEmaCli(const Value: String);
begin
  If (FEmaCli <> Value) Then
    FEmaCli := Value;
end;

procedure TfrmEnviarEmailDac.setNomCli(const Value: String);
begin
  If (FNomCli <> Value) Then
    FNomCli := Value;
end;

end.

