{***************************}
{* qryConTra -> CADTRA     *}
{* qryConTr2 -> CADTRA     *}
{************************JB*}

unit untDigObservacoes;

interface

uses
  SysUtils, Types, Classes, Variants, untPaiSimples, StdCtrls, EditFocus,
  Controls, Menus, ComCtrls, Buttons, ExtCtrls, {QTypes,} Graphics, Forms,
  Dialogs, QColorLabel, Uni, AppEvnts;

type
  TfrmDigObservacoes = class(TfrmPaiSimples)
    gpbTransportador: TGroupBox;
    gpbAtencao: TGroupBox;
    gpbObservacao: TGroupBox;
    pnlPedidoVenda: TPanel;
    Label2: TLabel;
    edtPedVen: TEditFocus;
    pnlDados: TPanel;
    edtObserv1: TEditFocus;
    edtObserv2: TEditFocus;
    edtObserv3: TEditFocus;
    edtObserv4: TEditFocus;
    edtObserv5: TEditFocus;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ColorLabel1: TColorLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtEndere: TEditFocus;
    edtCidade: TEditFocus;
    edtTipFre: TEditFocus;
    pnlFundo: TPanel;
    edtAtenca: TEditFocus;
    gpbFinalPed: TGroupBox;
    Label7: TLabel;
    edtFinaliza: TEditFocus;
    ColorLabel2: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPedVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
  private
    qryConTra: TUniQuery;
    qryConTr2: TUniQuery;

    function fEncontraPedidoVenda(strNumDoc: String): Boolean;
    procedure pCarregaTransportadora;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strObserv1: String;
    strObserv2: String;
    strObserv3: String;
    strObserv4: String;
    strObserv5: String;

    strCodTra: String;
    strNomTra: String;
    strEndere: String;
    strCidade: String;
    strTipFre: String;

    strAtenca: String;

    strFinPed: String;

    blnConfirma: Boolean;
  end;

var
  frmDigObservacoes: TfrmDigObservacoes;

implementation

uses untFuncoes, untfuncoesSimples, untModuloSPR,  DB,
  untConsultaFatPedOrc, untModuloFatGor, untModuloCadTra;

{$R *.dfm}

function TfrmDigObservacoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtObserv3) And (Not edtObserv4.Visible) Then
    Begin
      strObserv1  := edtObserv1.Text;
      strObserv2  := edtObserv2.Text;
      strObserv3  := edtObserv3.Text;
    End

    Else If (Sender = edtObserv5) Then
    Begin
      strObserv1  := edtObserv1.Text;
      strObserv2  := edtObserv2.Text;
      strObserv3  := edtObserv3.Text;
      strObserv4  := edtObserv4.Text;
      strObserv5  := edtObserv5.Text;
    End

    Else  If (Sender = edtCodTra) Then
    Begin
      If Not fEmptyStr(edtCodTra.Text) Then
      Begin
        pCarregaTransportadora;
        If qryConTr2.FieldByName('TRA_CODTRA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtTipFre) Then
    Begin

      If fEmptyStr(edtTipFre.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Tipo de Frete deve ser preenchido',['&O K']);
        Result := False;
      End
      Else
      If (edtTipFre.Text <> '1') And (edtTipFre.Text <> '2') Then
      Begin
        fMensagem('ATENÇÃO','O Campo Tipo de Frete deve conter somente 1 ou 2!',['&O K']);
        Result := False;
      End
      Else
      Begin
        strCodTra   := edtCodTra.Text;
        strNomTra   := edtNomTra.Text;
        strEndere   := edtEndere.Text;
        strCidade   := edtCidade.Text;
        strTipFre   := edtTipFre.Text;
      End;
    End

    Else If (Sender = edtFinaliza) Then
    Begin
      If fEmptyStr(edtFinaliza.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Finalização do Pedido deve ser preenchido',['&O K']);
        Result := False;
      End
      Else
      If (edtFinaliza.Text <> 'S') And (edtFinaliza.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO','O Campo Finalização do Pedido deve conter somente S ou N!',['&O K']);
        Result := False;
      End
      Else
      Begin
        strFinPed   := edtFinaliza.Text;      
        blnConfirma := True;
        Close;
      End;
    End

    Else If (Sender = edtAtenca) Then
    Begin
      strAtenca   := edtAtenca.Text;
      If gpbFinalPed.Visible = False Then
      Begin
        blnConfirma := True;
        Close;
      End;
    End;

  End;

  If Not Result Then
    Sender.SetFocus;
end;

Function fFormataFone(strFone: String): String;
Begin
  strFone := Trim(fTiraCaracEspeciaisParenteses(strFone));
  If Length(strFone) > 6 Then
  Begin
    Insert('-',strFone,Length(strFone)-3);

    If Length(strFone) > 8 Then
    Begin
      Insert(')',strFone,3);
      strFone := '('+ strFone;
    End;
  End;
  Result := strFone;
End;

procedure TfrmDigObservacoes.pCarregaTransportadora;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  TRA_CODTRA, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  TRA_ENDERE, ';
  strSQL := strSQL + '  TRA_BAIRRO, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO, ';
  strSQL := strSQL + '  TRA_FONE01  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (TRA_CODCID = CID_CODCID) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRA_CODTRA = :CODTRA ';

  With qryConTr2 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := edtCodTra.Text;
    Open;

    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
    edtEndere.Text := FieldByName('TRA_ENDERE').AsString + ' - ' + FieldByName('TRA_BAIRRO').AsString;
    edtCidade.Text := FieldByName('CID_NOMCID').AsString + ' - ' + FieldByName('CID_ESTADO').AsString +
                      ' - Fone: ' + fFormataFone(FieldByName('TRA_FONE01').AsString);

  End;
end;

procedure TfrmDigObservacoes.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  qryConTra := frmModuloCadTra.qryCadTra;
  qryConTr2 := fCriaQuery(Self);

  edtTipFre.Text   := '2';
  edtFinaliza.Text := 'N';

end;

procedure TfrmDigObservacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not fEmptyStr(edtPedVen.Text) Then
  Begin

    If Not fEncontraPedidoVenda(edtPedVen.Text) Then
    Begin
      fMensagem('','Não foi encontrado o pedido digitado!',['&OK']);
      Action := caNone;
    End;

  End;

  qryConTr2.Close;

End;

{********************************}
{* PESQUISA NO FATGOR SE EXISTE *}
{* O DOCUMENTO DIGITADO         *}
{*****************************AF*}
function TfrmDigObservacoes.fEncontraPedidoVenda(strNumDoc: String): Boolean;
  Var
    strSQL   : String;
    qryGenGor: TUniQuery;

Begin
  Try

    Result := True;

    qryGenGor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD" ';

    With qryGenGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If IsEmpty Then
        Result := False;

      Close;
    End;

  Finally
    FreeAndNil(qryGenGor);
  End;

End;


procedure TfrmDigObservacoes.edtPedVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;

    Key := #0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FGO_NUMDOC AS "Documento", ';
    strSQL := strSQL + '  FGO_ESPDOC AS "Especie", ';
    strSQL := strSQL + '  FGO_CODEMP AS "Empresa", ';
    strSQL := strSQL + '  FGO_CODCLI AS "Cod. Cliente", ';
    strSQL := strSQL + '  IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON) AS "Nome", ';
    strSQL := strSQL + '  CLI_EMAIL_, ';
    strSQL := strSQL + '  FGO_CODVEN AS "Vendedor", ';
    strSQL := strSQL + '  FGO_DTAENT AS "Data Documento", ';
    strSQL := strSQL + '  FGO_CONPAG AS "Cond. Pagamento", ';
    strSQL := strSQL + '  FORMAT(FGO_VLRCON, 2) AS "Valor", ';
    strSQL := strSQL + '  FATGOR.AUTOINCREM AS "AUTOINCREM" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR, ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  FGO_CODEMP = "' + VS_strCodEmp + '" AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD" ';

    stlCamInd.Add('FGO_NUMDOC');
    stlCamInd.Add('IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON)');
    stlCamInd.Add('FGO_CODVEN');
    stlCamInd.Add('FGO_DTAENT');

    stlDesInd.Add('Documento');
    stlDesInd.Add('Nome');
    stlDesInd.Add('Vendedor');
    stlDesInd.Add('Data Documento');

    Application.CreateForm(TfrmConsultaFatPedOrc, frmConsultaFatPedOrc);

    If (pConsultaEspecifica(Self, frmConsultaFatPedOrc, frmModuloFatGor.qryFatGor, 'FATGOR', strSQL, stlCamInd, stlDesInd)) Then
    Begin
      edtPedVen.Text := frmModuloFatGor.qryFatGor.FieldByName('FGO_NUMDOC').AsString;
    End;

    pFreeAndNil(frmConsultaFatPedOrc);

    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);

  End;

end;

procedure TfrmDigObservacoes.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposTra, stlCamIndTra, stlDesIndTra: TStringList;
begin
  inherited;
  stlCamposTra := TStringList.Create;
  stlCamIndTra := TStringList.Create;
  stlDesIndTra := TStringList.Create;

  If fEntraCons(Key) Then
  Begin

    stlCamposTra.Add('TRA_NOMTRA');
    stlCamposTra.Add('TRA_CODTRA');
    stlCamposTra.Add('TRA_ENDERE');
    stlCamposTra.Add('AUTOINCREM');

    stlCamIndTra.Add('TRA_NOMTRA');
    stlCamIndTra.Add('TRA_CODTRA');

    stlDesIndTra.Add('Nome');
    stlDesIndTra.Add('Código');

    If pConsultaRapida(Self, qryConTra, 'CADTRA', stlCamIndTra, stlDesIndTra, stlCamposTra) Then
    Begin
      edtCodTra.Text := qryConTra.FieldByName('TRA_CODTRA').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaTransportadora;

  End;

  FreeAndNil(stlCamposTra);
  FreeAndNil(stlCamIndTra);
  FreeAndNil(stlDesIndTra);

end;

end.

