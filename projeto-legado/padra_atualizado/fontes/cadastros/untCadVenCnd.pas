unit untCadVenCnd;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  ExtCtrls, BitBtnLockedIncrem, MemDS, DBAccess, Provider, Mask,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadVenCnd = class(TfrmPaiOrdena)
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaCND_CODCND: TStringField;
    cdsConsultaCND_CODEMP: TStringField;
    cdsConsultaCND_CODVEN: TStringField;
    cdsConsultaCND_CNDPAG: TStringField;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    Label8: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    btnConfirma: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strCodVen: String;

    procedure pExcluiCondicao;
    procedure pLimpaConsulta;
    procedure pVeSeGravaAlteracoes;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
  end;

implementation

uses SysUtils, untConsultas, untFuncoesSimples, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmCadVenCnd.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.ApplyUpdates(0);

  pLimpaConsulta;
end;

procedure TfrmCadVenCnd.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pExcluiCondicao;
end;

procedure TfrmCadVenCnd.btnSairClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;
    
end;

procedure TfrmCadVenCnd.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE : pExcluiCondicao;
  End;
end;

procedure TfrmCadVenCnd.edtCodCndKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqCondicoesPgto(Self, edtCodCnd, nil, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodCnd, True);
  End;

end;

procedure TfrmCadVenCnd.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodVen, True);
	End;

end;

function TfrmCadVenCnd.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodVen) Then
    Begin

      If fEmptyStr(edtCodVen.Text) Then
      Begin
        pMensagemOk('Informe o código do vendedor!');
        Result := False;
      End Else
      Begin
        edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          pMensagemOk('Vendedor não encontrado!');
          Result := False;
        End Else
        Begin
          strCodVen := edtCodVen.Text;
          fAbreConsulta;

          edtCodCnd.Enabled := True;

          pSetFocus(edtCodCnd);
          blnMudarFoco := False;
        End;

      End;

    End

    Else If (Sender = edtCodCnd) Then
    Begin

      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin

        mskCndPag.Text := fRetConPag(edtCodCnd.Text);

        If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Condição de pagamento não encontrado!');
        End Else
        With cdsConsulta Do
        Begin

          If Not Locate('CND_CODCND', edtCodCnd.Text, []) Then
          Begin
            blnPodeIncluir := True;
            Insert;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VENCND', VS_strCodEmp);
            FieldByName('CND_CODVEN').AsString := strCodVen;
            FieldByName('CND_CODEMP').AsString := VS_strCodEmp;
            FieldByName('CND_CODCND').AsString := edtCodCnd.Text;
            FieldByName('CND_CNDPAG').AsString := mskCndPag.Text;
            Post;
            blnPodeIncluir := False;
          End;

          edtCodCnd.Clear;
          mskCndPag.Clear;

          blnMudarFoco := False;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function  TfrmCadVenCnd.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   V.*, ';
  Result := Result + '   (SELECT CAST( CND_CNDPAG AS CHAR(100) ) FROM CADCND WHERE CND_CODIGO = V.CND_CODCND) AS CND_CNDPAG ';
  Result := Result + ' FROM ';
  Result := Result + '   VENCND V ';
  Result := Result + ' WHERE  ';
  Result := Result + '   CND_CODVEN = ' + QuotedStr(strCodVen);
End;

procedure TfrmCadVenCnd.pVeSeGravaAlteracoes;
Begin

  With cdsConsulta Do
  If Active And (ChangeCount > 0) Then
  Begin
    If fPergunta('Gravar as alterações realizadas?') Then
      ApplyUpdates(0)
    Else
      CancelUpdates;
  End;

End;

procedure TfrmCadVenCnd.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadVenCnd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrCancel Then
    pVeSeGravaAlteracoes;

end;

procedure TfrmCadVenCnd.FormCreate(Sender: TObject);
begin
  inherited;
  mskCndPag.EditMask := MASK_CONPAG;
end;

procedure TfrmCadVenCnd.pLimpaConsulta;
Begin
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodCnd.Clear;
  edtCodCnd.Enabled := False;
  mskCndPag.Clear;
  cdsConsulta.Close;
  pSetFocus(edtCodVen);
End;

procedure TfrmCadVenCnd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: Begin
                 pVeSeGravaAlteracoes;
                 pLimpaConsulta;
                 Abort;
               End

    Else inherited;
  End;
end;

procedure TfrmCadVenCnd.FormShow(Sender: TObject);
begin
  inherited;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

end;

procedure TfrmCadVenCnd.pExcluiCondicao;
Begin
  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão da condição de pagamento?') Then
      Delete;
  End;
End;

end.
