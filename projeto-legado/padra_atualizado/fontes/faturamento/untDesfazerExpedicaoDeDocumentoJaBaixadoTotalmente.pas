unit untDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, MemoFocus, untConstantes;

type
  TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente = class(TfrmPai)
    pnlRodape: TPanel;
    btnLimpaExpedicao: TBitBtnLocked;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label3: TLabel;
    pnlCentro: TPanel;
    memInfDoc: TMemoFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLimpaExpedicaoClick(Sender: TObject);
  private
    { Private declarations }
    function fOrigemDocumento(const strEspDoc: String): String;
  public

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function fCarregouDocumento : Boolean;
    function fGetSQL : String;

    procedure pHabilitarPanels(blnFiltrou : Boolean);

  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente }

procedure TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.btnLimpaExpedicaoClick(Sender: TObject);
var
  strDoc : String;
  qryAux : TUniQuery;

const
  strAutInc = 'SELECT AUTOINCREM FROM MOVDET WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :EMPDOC AND DET_ORIDOC = :ORIDOC ';

  strUpdDet = 'UPDATE                             ' +
              '  MOVTRI MT                        ' +
              'JOIN                               ' +
              '  MOVDET MD                        ' +
              'ON (MT.DET_SEQGER = MD.AUTOINCREM) ' +
              'SET                                ' +
              '  DET_QTDEXP = 0                   ' +
              'WHERE                              ' +
              '  MD.DET_NUMDOC =:NUMDOC AND       ' +
              '  MD.DET_ESPDOC =:ESPDOC AND       ' +
              '  MD.DET_CODEMP =:EMPDOC AND       ' +
              '  MD.DET_ORIDOC =:ORIDOC           ';

  strDelSepDet = 'SELECT * FROM SEPDET WHERE DET_SEQGER IN (' + strAutInc + ')';

  function fRetornaSQLUpdateMovGer: String;
  begin
    Result := 'UPDATE   ' +
             '  MOVGER ' +
             'SET      ' +
             '  GER_OPLBEX = NULL, ' +
             '  GER_DTLBEX = NULL, ' +
             '  GER_HRLBEX = NULL  ' +
             IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,
             ' , GER_SEPEXP = NULL ' +
             ' , GER_MENEXP = NULL ' +
             ' , GER_OPEEXP = NULL ', EmptyStr)+
             'WHERE                ' +
             '  GER_NUMDOC = :NUMDOC AND ' +
             '  GER_ESPDOC = :ESPDOC AND ' +
             '  GER_CODEMP = :EMPDOC AND ' +
             '  GER_ORIDOC = :ORIDOC ';
  end;

begin

  inherited;

  If Not pnlRodape.Visible Then
    Exit;

  strDoc := edtNumDoc.Text + '-' + edtEspDoc.Text + '-' + edtCodEmp.Text;

  If (fMensagem('', 'Deseja realmente limpar a expedição do documento ' + strDoc + '?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    If fUsaRomaneioDocsExpedidos Then
      If fDocumentoEstaEmRomaneio(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
        Exit;

    qryAux := fCriaQuery;

    Try

      fStartTransaction;

      Try

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strUpdDet);
        qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        qryAux.ParamByName('EMPDOC').AsString := edtCodEmp.Text;
        qryAux.ParamByName('ORIDOC').AsString := fOrigemDocumento(edtEspDoc.Text);
        qryAux.ExecSQL;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(fRetornaSQLUpdateMovGer);
        qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        qryAux.ParamByName('EMPDOC').AsString := edtCodEmp.Text;
        qryAux.ParamByName('ORIDOC').AsString := fOrigemDocumento(edtEspDoc.Text);
        qryAux.ExecSQL;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strDelSepDet);
        qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        qryAux.ParamByName('EMPDOC').AsString := edtCodEmp.Text;
        qryAux.ParamByName('ORIDOC').AsString := fOrigemDocumento(edtEspDoc.Text);
        qryAux.Open;

        qryAux.First;
        While Not qryAux.Eof Do
        Begin
          fVerificaIntegridade('TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente', 'SEPDET', qryAux, True);
          qryAux.Delete;
        End;

       If fCommit Then
        Begin
          fMensagem('', 'A expedição do documento ' + strDoc + ' foi desfeita com sucesso!', ['&Ok']);
          pHabilitarPanels(False);
          ModalResult := mrOk;
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message,'[btnLimpaExpedicaoClick]');
      End;

    Finally
      FreeAndNil(qryAux);
    End;

  End;

end;

procedure TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin

  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.fCarregouDocumento: Boolean;
var
  qryItens : TUniQuery;
begin

  If fEmptyStr(edtNumDoc.Text) Then
    Exit(False);

  If fEmptyStr(edtEspDoc.Text) Then
    Exit(False);

  If fEmptyStr(edtCodEmp.Text) Then
    Exit(False);

  qryItens := fCriaQuery;

  Try

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add(fGetSQL);
    qryItens.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryItens.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryItens.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryItens.ParamByName('ORIDOC').AsString := fOrigemDocumento(edtEspDoc.Text);
    qryItens.Open;

    memInfDoc.Lines.Clear;

    If Not qryItens.IsEmpty Then
    Begin

      memInfDoc.Lines.Add('');
      memInfDoc.Lines.Add('Cliente: ' + qryItens.FieldByName('CODCLI').AsString + '-' + fRetNomCliente(qryItens.FieldByName('CODCLI').AsString));
      memInfDoc.Lines.Add('Vendedor: ' + qryItens.FieldByName('CODVEN').AsString + '-' + fRetNomVendRep(qryItens.FieldByName('CODVEN').AsString));
      memInfDoc.Lines.Add('Dt. Emissão: ' + qryItens.FieldByName('DTAENT').AsString + ' Vr. Total: ' + FormatFloat('#,##0.00', qryItens.FieldByName('VLRCON').AsFloat));
      memInfDoc.Lines.Add('Dt. Entrega: ' + qryItens.FieldByName('DTENTR').AsString);

      memInfDoc.Lines.Add('');
      memInfDoc.Lines.Add('Dt. Expedição: ' + qryItens.FieldByName('DTAEXP').AsString + '-' + qryItens.FieldByName('HOREXP').AsString);
      memInfDoc.Lines.Add('Operador: ' + qryItens.FieldByName('OPEEXP').AsString + '-' + fRetNomeOperador(qryItens.FieldByName('OPEEXP').AsString));

      pHabilitarPanels(True);

    End;

    Result := (qryItens.RecordCount > 0);

  Finally
    FreeAndNil(qryItens);
  End;

end;

function TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.fGetSQL: String;
begin

  Result := 'SELECT          ' +
            '  G.GER_CODCLI AS CODCLI, ' +
            '  G.GER_CODVEN AS CODVEN, ' +
            '  G.GER_DTAENT AS DTAENT, ' +
            '  G.GER_VLRCON AS VLRCON, ' +
            '  G.GER_DTLBEX AS DTAEXP, ' +
            '  G.GER_HRLBEX AS HOREXP, ' +
            '  G.GER_OPLBEX AS OPEEXP, ' +
            '  G.GER_DTENTR AS DTENTR  ' +
            'FROM                      ' +
            '  MOVGER G                ' +
            'WHERE G.GER_NUMDOC = :NUMDOC ' +
            '  AND G.GER_ESPDOC = :ESPDOC ' +
            '  AND G.GER_CODEMP = :CODEMP ' +
            '  AND G.GER_ORIDOC = :ORIDOC '+
            '  AND G.GER_DTLBEX IS NOT NULL ';

end;

procedure TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_ESCAPE) Then
    If (pnlRodape.Visible) Then
      pHabilitarPanels(False)
    Else
      inherited;

end;

function TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('', 'O número do documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('', 'A espécie do documento deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('', 'A empresa deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End;
      End;
    End;

    If (Result) And
       (Not pnlRodape.Visible) And
       (Not fEmptyStr(edtNumDoc.Text)) And
       (Not fEmptyStr(edtEspDoc.Text)) And
       (Not fEmptyStr(edtCodEmp.Text)) Then
    Begin

      If Not fCarregouDocumento Then
      Begin
        fMensagem('', 'Documento não encontrado ou não expedido totalmente!', ['&OK']);
        Exit;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.pHabilitarPanels(blnFiltrou: Boolean);
begin

  pnlCentro.Visible := blnFiltrou;
  pnlRodape.Visible := blnFiltrou;

  pnlCabecalho.Enabled := Not blnFiltrou;

  If Not blnFiltrou Then
  Begin

    edtNumDoc.Clear;
    edtEspDoc.Clear;
    edtCodEmp.Clear;
    edtNomEmp.Clear;

    pSetFocus(edtNumDoc);

  End;

end;

function TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.fOrigemDocumento(const strEspDoc: String): String;
begin
  Result := '';

  If (strEspDoc = 'TL') Then
    Exit;

  Result := 'V';
end;

end.
