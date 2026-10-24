unit untFatAltEmbarcacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, System.StrUtils, DB;

type
  TfrmFatAltEmbarcacoes = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlBusca: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDocum: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    lblVenAtu: TLabel;
    Label7: TLabel;
    lblRepAtu: TLabel;
    edtCodCli: TEditFocus;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    edtDesCli: TEditFocus;
    edtDesVen: TEditFocus;
    edtValDoc: TEditFocus;
    edtCodVen: TEditFocus;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    pnlFundo: TPanel;
    lblNomEmb: TLabel;
    edtCodEmb: TEditFocus;
    edtNomEmb: TEditFocus;
    Label9: TLabel;
    edtCodEmbAtual: TEditFocus;
    edtNomEmbAtual: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
  private
    strTabela: String;
    strAutinc: string;
    procedure pCarregaDados(qryDados: TUniQuery);
    function fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp: String): Boolean;
    procedure pLimpaTela;
    procedure pGravaDocumento;
    { Private declarations }
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas;

procedure TfrmFatAltEmbarcacoes.FormShow(Sender: TObject);
begin
  inherited;
  edtDocum.TamCampo  := fTamDocCadRec;
  edtDocum.MaxLength := fTamDocCadRec;
  pLimpaTela;
end;

function TfrmFatAltEmbarcacoes.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End
        Else If blnBuscaPorChave And (Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
        Begin
          fMensagem('','Documento digitado não foi encontrado, verifique !',['&O K']);
          Result := False;
        End
        Else
        Begin
          pSetFocus(edtCodEmb);
          blnMudarFoco:=False;
        End
      End;
    End

    Else If (Sender = edtCodEmb) Then
    Begin
      If (Not fEmptyStr(edtCodEmb.Text)) Then
      Begin
        edtNomEmb.Text := fRetNomEmbarcacao(edtCodEmb.Text);

        If (fEmptyStr(edtNomEmb.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código de embarcação não é válido. Verifique!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(edtCodEmb.Text)) And
             (Not fEmbarcacaoVinculadaCliente(edtCodCli.Text, edtCodEmb.Text)) Then
          Begin
            fMensagem('','A Embarcação selecionada não está vinculada ao cliente informado!',['&OK']);
            edtCodEmb.Text := '';
            edtNomEmb.Text := '';
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtNomEmb.Text := '';
      End;
    End;

  End;
End;

procedure TfrmFatAltEmbarcacoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(strAutinc) Then
    Exit;

  If fEmptyStr(edtCodEmb.Text) Then
    If fMensagem('ATENÇÃO!','Deseja remover a embarcação do documento ?', ['Sim','Não']) = 2 Then
      Exit;

  If fMensagem('ATENÇÃO!','Deseja gravar a alteração ?', ['Sim','Não']) = 1 Then
    pGravaDocumento;

end;

procedure TfrmFatAltEmbarcacoes.pGravaDocumento;
var qryUpdate: TUniQuery;
    strCodEmb: String;
Begin
  Try
    qryUpdate := fCriaQuery(Nil);

    If not fEmptyStr(edtCodEmb.Text) Then
      strCodEmb := fCampoTabela('AUTOINCREM', 'CADEMB', ['EMB_CODEMB'], [edtCodEmb.Text], False);

    With qryUpdate, SQL do
    Begin
      Clear;
      If fEmptyStr(edtCodEmb.Text) Then
      Begin
        If strTabela = 'MOVGER' Then
          Add('UPDATE AUXMOV SET AUX_CODEMB = NULL')
        Else
          Add('UPDATE AUXNOT SET AUX_CODEMB = NULL');
      End
      Else
      If strTabela = 'MOVGER' Then
        Add('UPDATE AUXMOV SET AUX_CODEMB = :CODEMB')
      Else
        Add('UPDATE AUXNOT SET AUX_CODEMB = :CODEMB');

      Add('WHERE AUX_SEQGER = :AUTINC');
      If not fEmptyStr(edtCodEmb.Text) Then
        ParamByName('CODEMB').AsString := strCodEmb;
      ParamByName('AUTINC').AsString := strAutinc;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryUpdate);
  End;

  pLimpaTela;
End;

procedure TfrmFatAltEmbarcacoes.edtCodEmbKeyPress(Sender: TObject;
  var Key: Char);
Var arrCadEmb: TConsultasArray;
begin
  inherited;
  If not fEmptyStr(strAutinc) Then
    If fPesqCadastroEmbarcacoes(Self, edtCodEmb, edtNomEmb, Nil, Key, arrCadEmb, True, edtCodCli.Text) Then
    Begin
      If fValidaCampos(edtCodEmb, True) Then
        SelectNext(ActiveControl, True, True);
    End;
end;

procedure TfrmFatAltEmbarcacoes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltEmbarcacoes.fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryGen : TUniQuery;
    strSql : String;
    strSQLMovGer : String;
    strSQLNotGer : String;
begin
  strSQLMovGer := '';
  strSQLMovGer := strSQLMovGer + '  SELECT SQL_NO_CACHE                           ';
  strSQLMovGer := strSQLMovGer + '    "MOVGER" AS TABGER,                         ';
  strSQLMovGer := strSQLMovGer + '    MOVGER.AUTOINCREM AS AUTGER,                ';
  strSQLMovGer := strSQLMovGer + '    GER_CODCLI AS CODCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    CLI_NOMCLI AS NOMCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CODREP AS CODREP,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_DTAENT AS DTAENT,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_VLRCON AS VALDOC,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CONPAG AS CONPAG,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CODVEN AS CODVEN,                       ';
  strSQLMovGer := strSQLMovGer + '    OPE_NOMOPE AS NOMVEN,                       ';
  strSQLMovGer := strSQLMovGer + '    AUX_CODEMB AS CODEMB,                       ';
  strSQLMovGer := strSQLMovGer + '    (SELECT OPE_NOMOPE                          ';
  strSQLMovGer := strSQLMovGer + '     FROM                                       ';
  strSQLMovGer := strSQLMovGer + '       CADOPE                                   ';
  strSQLMovGer := strSQLMovGer + '     WHERE OPE_CODOPE = GER_CODREP) AS NOMREP   ';
  strSQLMovGer := strSQLMovGer + '  FROM                                          ';
  strSQLMovGer := strSQLMovGer + '    MOVGER                                      ';
  strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';
  strSQLMovGer := strSQLMovGer + '    INNER JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM';
  strSQLMovGer := strSQLMovGer + '  WHERE                                         ';
  strSQLMovGer := strSQLMovGer + '    GER_NUMDOC =:NUMDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_ESPDOC =:ESPDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_CODEMP =:CODEMP AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_TIP_FC = "C"                            ';

  strSQLNotGer := AnsiReplaceStr(strSQLMovGer, 'MOVGER', 'NOTGER');
  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'AUXMOV', 'AUXNOT');

  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'GER_CODREP', '""');
  strSql := strSQLMovGer + ' UNION ALL ' + strSQLNotGer;

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumdoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If IsEmpty Then
      Result := False
    Else
    Begin
      pCarregaDados(qryGen);
      Result := True;
    End;

  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatAltEmbarcacoes.pCarregaDados(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    strTabela      := FieldByName('TABGER').AsString;
    strAutinc      := FieldByName('AUTGER').AsString;
    edtCodCli.Text := FieldByName('CODCLI').AsString;
    edtDesCli.Text := FieldByName('NOMCLI').AsString;
    edtDtaFat.Text := FormatDateTime('DD/MM/YY', FieldByName('DTAENT').AsDateTime);
    edtConPag.Text := fFormataCondPag(FieldByName('CONPAG').AsString);
    edtValDoc.Text := FormatFloat('##,#0.00', FieldByName('VALDOC').AsFloat);
    edtCodVen.Text := FieldByName('CODVEN').AsString ;
    edtDesVen.Text := FieldByName('NOMVEN').AsString;
    edtCodEmbAtual.Text := fCampoTabela('EMB_CODEMB', 'CADEMB', ['AUTOINCREM'], [FieldByName('CODEMB').AsString]);
    edtNomEmbAtual.Text := fRetNomEmbarcacao(edtCodEmbAtual.Text);

    btnConfirma.Enabled := True;
    pnlBusca.Enabled    := False;
    edtCodEmb.ReadOnly  := False;
  End;
end;

procedure TfrmFatAltEmbarcacoes.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  strTabela := '';
  strAutinc := '';

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  btnConfirma.Enabled := False;
  pnlBusca.Enabled    := True;
  edtCodEmb.ReadOnly  := True;

  pSetFocus(edtDocum);
end;


end.
