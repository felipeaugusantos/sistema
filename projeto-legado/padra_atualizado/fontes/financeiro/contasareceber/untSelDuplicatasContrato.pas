unit untSelDuplicatasContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils,
  Math, BitBtnLockedIncrem, Datasnap.Provider, MemDS, DBAccess,
  Datasnap.DBClient, frxExportCSVTestabilidade;

type
  TfrmSelDuplicatasContrato = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    lblCheque: TLabel;
    edtContrato: TEditFocus;
    dbgDupSel: TDBGridCitel;
    Panel1: TPanel;
    Panel2: TPanel;
    splAplicacao: TSplitter;
    dtsDupSel: TDataSource;
    spbClientes: TSpeedButton;
    btnExcluir: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtContratoEnter(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtContratoChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure spbClientesClick(Sender: TObject);
  private
    { Private declarations }

    procedure pCancela(blnPerguntar: Boolean = True);
    Procedure pSetaRequeridos;
    procedure pCriaCdsDuplicatasSelecionadas;
    procedure pSelecionaDuplicata;
    procedure pVoltaDuplicataDaSelecao;    

  public
    { Public declarations }

    cdsDuplicatasSelecionadas: TUniClientDataSet;

    fSqlDuplicatas: function(strRomaneio: String = ''): String of object;

  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
  end;

implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

Procedure TfrmSelDuplicatasContrato.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
    For intIndex := 0 To FieldDefs.Count - 1 Do
      FieldDefs[intIndex].Required := FALSE;
End;

function TfrmSelDuplicatasContrato.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmSelDuplicatasContrato.fGetSql(blnLike: Boolean): String;
Begin
  Result := fSqlDuplicatas;
  Result := Result + 'WHERE ';

  If (fEmptyStr(edtContrato.Text)) Then
    Result := Result + ' FALSE '

  Else
  Begin
    Result := Result + '  CTR_DTAREC IS NULL AND ';
    Result := Result + '  CTR_BARCON <> "" ';

    If Length(edtContrato.Text) = 8 Then
      Result := Result + '  AND CTR_CODCLI = ' + QuotedStr(edtContrato.Text)
    Else
      Result := Result + '  AND CTR_BARCON = ' + QuotedStr(edtContrato.Text);

    Result := Result + '  AND (IFNULL(FGO_BOLADT, 0.00) = 0.00)  ';
  End;
  
End;

procedure TfrmSelDuplicatasContrato.pCancela(blnPerguntar: Boolean = True);
Begin
  If (edtContrato.Focused) Then
    Close
  Else
  Begin
    If (Not blnPerguntar) Or
            (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
    Begin
      pLimpaPesquisa;
      pSetFocus(edtContrato);
    End;

    Abort;
  End;

End;

procedure TfrmSelDuplicatasContrato.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F1:  Begin
              Key := 0;
              spbClientes.Click;
            End;

    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_RETURN: Begin
                 If (dbgConsulta.Focused) Then
                 Begin
                   pSelecionaDuplicata;
                   Key := 0;
                 End;
               End;


    VK_DELETE: Begin
                 If dbgDupSel.Focused Then
                 Begin
                    btnExcluir.Click;
                    Key := 0;
                 End

                 Else If Shift = [ssCtrl] Then
                   Key := 0;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                   inherited
                 Else
                    pCancela(False);
               end;

    Else inherited;
  End;

end;

procedure TfrmSelDuplicatasContrato.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pCriaCdsDuplicatasSelecionadas;

  pSetFocus(edtContrato);
end;

procedure TfrmSelDuplicatasContrato.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pLimpaPesquisa;
  
  If cdsDuplicatasSelecionadas.IsEmpty Then
    pMensagemOk('Nenhuma duplicata foi selecionada!')
  Else
    ModalResult := mrOk;  
end;

procedure TfrmSelDuplicatasContrato.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgDupSel);
  pVoltaDuplicataDaSelecao;
end;

procedure TfrmSelDuplicatasContrato.btnSairClick(Sender: TObject);
begin
  pCancela(False);
end;

procedure TfrmSelDuplicatasContrato.edtContratoChange(Sender: TObject);
begin
  inherited;
  If Length(edtContrato.Text) = 13 Then
  Begin
    If fAbreConsulta(False) And (Not cdsConsulta.IsEmpty) Then
      pSetFocus(dbgConsulta)
    Else
    Begin
      pMensagemOk('Nehuma duplicata foi encontrada para este número de contrato!');
      pSetFocus(edtContrato);
    End;
  End;
end;

procedure TfrmSelDuplicatasContrato.edtContratoEnter(Sender: TObject);
begin
  inherited;
  edtContrato.Clear;
  cdsConsulta.Close;
end;

function TfrmSelDuplicatasContrato.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := (inherited fAbreConsulta(blnLike));
  pSetaRequeridos;

  TFloatField(cdsConsulta.FieldByName('CTR_VALDUP')).DisplayFormat := fMskDigitos(2);
End;

procedure TfrmSelDuplicatasContrato.pCriaCdsDuplicatasSelecionadas;
begin
  edtContrato.Clear;

  fAbreConsulta(False);

  cdsDuplicatasSelecionadas := TUniClientDataSet.Create(Self);
  cdsDuplicatasSelecionadas.Data := cdsConsulta.Data;

  cdsDuplicatasSelecionadas.IndexFieldNames := 'CTR_DUPPAR;CTR_ESPDOC;CTR_CODEMP;';

  TFloatField(cdsDuplicatasSelecionadas.FieldByName('CTR_VALDUP')).DisplayFormat := fMskDigitos(2);

  dtsDupSel.DataSet := cdsDuplicatasSelecionadas;
end;

procedure TfrmSelDuplicatasContrato.pSelecionaDuplicata;
  var
    intCont: Integer;
begin
  If (Not cdsConsulta.IsEmpty) And (fMensagem('', 'Confirma seleção desta duplicata?', ['','']) = 1) Then
  Begin
    If cdsDuplicatasSelecionadas.Locate('CTR_DUPPAR;CTR_ESPDOC;CTR_CODEMP;',
      VarArrayOf([cdsConsulta.FieldByName('CTR_DUPPAR').AsString,
                  cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                  cdsConsulta.FieldByName('CTR_CODEMP').AsString]), []) Then
    Begin
      pMensagemOk('Esta duplicata já foi selecionada!');
    End
    Else
    Begin
      cdsDuplicatasSelecionadas.Append;

      For intCont := 0 To cdsConsulta.Fields.Count - 1 Do
        cdsDuplicatasSelecionadas.Fields[intCont].Value := cdsConsulta.Fields[intCont].Value;

      cdsDuplicatasSelecionadas.Post;
    End;

    cdsConsulta.Delete;
  End;
end;

procedure TfrmSelDuplicatasContrato.pVoltaDuplicataDaSelecao;
  var
    intCont: Integer;
begin

  If Not cdsConsulta.Active Then
  Begin
    edtContrato.Clear;
    fAbreConsulta(False);
  End;

  If (cdsDuplicatasSelecionadas.Active) And
     (Not cdsDuplicatasSelecionadas.IsEmpty) Then
  Begin
    If Not cdsConsulta.Locate('CTR_DUPPAR;CTR_ESPDOC;CTR_CODEMP;',
      VarArrayOf([cdsDuplicatasSelecionadas.FieldByName('CTR_DUPPAR').AsString,
                  cdsDuplicatasSelecionadas.FieldByName('CTR_ESPDOC').AsString,
                  cdsDuplicatasSelecionadas.FieldByName('CTR_CODEMP').AsString]), []) Then
    Begin
      blnPodeIncluir := True;

      cdsConsulta.Append;

      For intCont := 0 To cdsDuplicatasSelecionadas.Fields.Count - 1 Do
        cdsConsulta.Fields[intCont].Value := cdsDuplicatasSelecionadas.Fields[intCont].Value;

      cdsConsulta.Post;

      blnPodeIncluir := False;
    End;

    cdsDuplicatasSelecionadas.Delete;
  End;
end;

procedure TfrmSelDuplicatasContrato.spbClientesClick(Sender: TObject);
  Var
    Key: Char;
    arrClientes: TConsultasArray;
begin
   Key := '?';

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtContrato, nil, nil, Key, arrClientes) Then
  Begin
    fAbreConsulta(False);
    edtContrato.Clear;    
  End;
end;

end.
