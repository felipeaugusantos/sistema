unit untFatDigDadosConsignacao;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatDigDadosConsignacao = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    mskDtaEnt: TMaskEditFocus;
    mskDtaDoc: TMaskEditFocus;
    lbl3: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    lbl4: TLabel;
    edtSerie: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function fDocumentoExiste : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strCodCli : string;

    { Public declarations }
  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

function TfrmFatDigDadosConsignacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtNumDoc Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Nº do documento!', ['&O k']);
        Result := False;
      End;
    End

    Else If Sender = edtEspDoc Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a espécie do documento!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = mskDtaEnt) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de entrada deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaDoc) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaDoc.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do documento deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtSerie) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(edtSerie.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Série deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigDadosConsignacao.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmFatDigDadosConsignacao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If Not fDocumentoExiste Then
    Begin
      ModalResult := mrOk;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Já existe um documento com esse número (' + edtNumDoc.Text + '-' + edtEspDoc.Text + ')!', ['&O k']);
      pSetFocus(edtNumDoc);
      Exit;
    End;
  End;
end;

procedure TfrmFatDigDadosConsignacao.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmFatDigDadosConsignacao.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaEnt.Text := DateToStr(Date);

  mskDtaDoc.Text := EmptyStr;
  edtNumDoc.Text := EmptyStr;
  edtSerie.Text  := EmptyStr;
end;

function TfrmFatDigDadosConsignacao.fDocumentoExiste : Boolean;
  Var
    strSQL: String;
    qryGenGer: TUniQuery;
begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' MOVDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      Open;
      Result := Not fEmptyStr(FieldByName('AUTOINCREM').AsString);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

End.

