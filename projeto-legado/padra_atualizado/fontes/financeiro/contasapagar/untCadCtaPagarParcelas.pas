unit untCadCtaPagarParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.StdCtrls, EditFocus,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, System.Generics.Collections, Aurelius.Bind.Dataset,
  untTCadPag, untTCadPagRepository, System.StrUtils, System.Math,
  untTypesSistema;

type
  TfrmCadCtaPagarParcelas = class(TfrmPai)
    pnlFundo: TPanel;
    pnlDados: TPanel;
    Label9: TLabel;
    edtValor: TEditFocus;
    rdgAltVal: TRadioGroup;
    btnCancela: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    pnlTotal: TPanel;
    Label23: TLabel;
    Label1: TLabel;
    edtValTot: TEditFocus;
    edtQtdPar: TEditFocus;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicNivel: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    grdDuplicDadosCTP_NUMDUP: TcxGridDBColumn;
    grdDuplicDadosCTP_PARCEL: TcxGridDBColumn;
    grdDuplicDadosCTP_SERIE_: TcxGridDBColumn;
    grdDuplicDadosCTP_CODFOR: TcxGridDBColumn;
    grdDuplicDadosCTP_CODEMP: TcxGridDBColumn;
    grdDuplicDadosCTP_DTACAD: TcxGridDBColumn;
    grdDuplicDadosCTP_DTAVEN: TcxGridDBColumn;
    grdDuplicDadosCTP_VALDUP: TcxGridDBColumn;
    dtsCadPag: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    FstrNumDup: String;
    FstrSerie: String;
    FstrCodForn: String;
    FstrCodEmp: String;
    blnAlterado: Boolean;
    arrLockParc: TStringArray;
    lstCadPag: TList<TCadPag>;
    cdsCadPag: TAureliusDataset;
    objRep: TCadPagRepository;
    fltTotVen: Double;

    procedure pValidaParcelas;
    function fValidaValores: Boolean;
  public
    { Public declarations }
    blnAltPar: Boolean;
    strAutoincAtual: String;

    procedure pCarregaParcelas(const strNumDup, strSerie, strCodForn, strCodEmp: String);
    function  fLockParcela(const strChave: String): Boolean;
    procedure pUnlockParcelas;
  end;

var
  frmCadCtaPagarParcelas: TfrmCadCtaPagarParcelas;

implementation

uses
  untObjectManager, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCtaPagarParcelas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstCadPag);
  FreeAndNil(objRep);
  FreeAndNil(cdsCadPag);

  pCarregaParcelas(FstrNumDup, FstrSerie, FstrCodForn, FstrCodEmp);
end;

procedure TfrmCadCtaPagarParcelas.btnConfirmarClick(Sender: TObject);
  Var
    fltValor, fltDif: Double;

  function fGetValParc: Double;
  begin
    Result := fFormataFloat((fltTotVen - fltValor) / (cdsCadPag.RecordCount -1), 2);
  end;

  function fGetDifParc: Double;
  begin
    Result := fFormataFloat((fGetValParc * (cdsCadPag.RecordCount -1) - (fltTotVen - fltValor)), 2);
  end;

  procedure pAlteraValor(const AValor: Double);
  begin
    cdsCadPag.Edit;
    cdsCadPag.Current<TCadPag>.fltValOri := AValor;
    cdsCadPag.Current<TCadPag>.fltValDup := AValor;
    cdsCadPag.Post;
  end;
begin
  inherited;
  If fStrToFloat(edtValor.Text) <= 0 Then
  Begin
    pMensagemOK('O valor deve ser maior que zero!');
    pSetFocus(edtValor);
    Exit;
  End;

  If fStrToFloat(edtValor.Text) >= fltTotVen Then
  Begin
    pMensagemOK('O valor da parcela não pode ser igual ou superior ao valor total!');
    pSetFocus(edtValor);
    Exit;
  End;

  fltValor := fFormataFloat(fStrToFloat(edtValor.Text), 2);

  If rdgAltVal.ItemIndex < 2 Then
  Begin
    fltDif := fGetDifParc;

    If fMensagem('ATENÇÃO', 'Ao escolher a opção "' + rdgAltVal.Items[rdgAltVal.ItemIndex] +
                            '", o sistema alterará a ' + AnsiLowerCase(rdgAltVal.Items[rdgAltVal.ItemIndex]) +
                            ' pelo valor digitado e recalculará todas as outras. Deseja continuar?',
                            ['Sim', 'Não']) = 2 Then
      Exit;
  End
  Else
    fltDif := 0.00;

  cdsCadPag.DisableControls;
  Try
    Case rdgAltVal.ItemIndex Of
      0: Begin //primeira
           cdsCadPag.First;
           pAlteraValor(fltValor);
           cdsCadPag.Next;

           //ajusta o restante nas outras parcelas
           fltValor := fGetValParc;

           While Not cdsCadPag.Eof Do
           Begin
             pAlteraValor(fltValor);
             cdsCadPag.Next;
           End;
         End;

      1: Begin //última
           cdsCadPag.Last;
           pAlteraValor(fltValor);
           cdsCadPag.Prior;

           //ajusta o restante nas outras parcelas
           fltValor := fGetValParc;

           While Not cdsCadPag.Bof Do
           Begin
             pAlteraValor(fltValor);
             cdsCadPag.Prior;
           End;
         End;

      2: Begin //todas
           cdsCadPag.First;
           While Not cdsCadPag.Eof Do
           Begin
             pAlteraValor(fltValor);
             cdsCadPag.Next;
           End;
         End;
    End;

    {*************************************************}
    {* AJUSTA A DIFERENÇA NA PRIMEIRA/ÚLTIMA PARCELA *}
    {*REQ*155086***********************************RP*}
    If fltDif <> 0 Then
      pAlteraValor(cdsCadPag.Current<TCadPag>.fltValDup - fltDif);

    pSetFocus(grdDuplic);
  Finally
    blnAlterado := True;
    cdsCadPag.EnableControls;
    pValidaParcelas;
  End;
end;

procedure TfrmCadCtaPagarParcelas.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not blnAlterado Then
  Begin
    pMensagemOK('É necessário alterar algum valor para continuar.');
    Exit;
  End;

  If Not SameValue(fStrToFloat(edtValTot.Text), fltTotVen) Then
  Begin
    pMensagemOK('Valor total gerado não bate com o valor total da venda. Verifique!');
    Exit;
  End;

  If Not fValidaValores Then
  Begin
    pMensagemOK('O Valor das parcelas deve ser maior que 0 (zero)!');
    pSetFocus(grdDuplic);
    Exit;
  End;

  If fMensagem('CONFIRMAÇÃO', 'Confirma a alteração de valor da(s) parcela(s)?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    fStartTransaction;

    cdsCadPag.DisableControls;
    Try
      cdsCadPag.First;
      While Not cdsCadPag.Eof Do
      Begin
        objRep.fAtualizar(cdsCadPag.Current<TCadPag>, 'ALTERAÇÃO', Self.Name);
        cdsCadPag.Next;
      End;
    Finally
      cdsCadPag.EnableControls;
    End;

    //persiste no banco, tabela principal (CADPAG) e log (LOGCTP)
    frwk.objDBManager.Flush;

    fCommit;

    pMensagemOK('Dados gravados com sucesso!');
    Close;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao alterar as parcelas. Erro gerado: ' + E.Message, '[untCadCtaPagarParcelas.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadCtaPagarParcelas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pUnLockParcelas;

  FreeAndNil(cdsCadPag);
  FreeAndNil(lstCadPag);
  FreeAndNil(objRep);
end;

procedure TfrmCadCtaPagarParcelas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnGravar.Click;
  End;
end;

function TfrmCadCtaPagarParcelas.fValidaValores: Boolean;
begin
  cdsCadPag.DisableControls;
  Try
    cdsCadPag.First;
    While Not cdsCadPag.Eof Do
    Begin
      If cdsCadPag.Current<TCadPag>.fltValDup <= 0 Then
        Exit(False);

      cdsCadPag.Next;
    End;

    Result := True;
  Finally
    cdsCadPag.EnableControls;
  End;
end;

procedure TfrmCadCtaPagarParcelas.pCarregaParcelas(const strNumDup, strSerie,
  strCodForn, strCodEmp: String);
begin
  FstrNumDup  := strNumDup;
  FstrSerie   := strSerie;
  FstrCodForn := strCodForn;
  FstrCodEmp  := strCodEmp;

  blnAlterado := False;
  objRep    := TCadPagRepository.Create;
  lstCadPag := objRep.fRetDuplicatas(strNumDup, strCodEmp, strCodForn, strSerie);
  cdsCadPag := TAureliusDataset.Create(Self);
  cdsCadPag.SetSourceObject(frwk);
  cdsCadPag.SetSourceList(lstCadPag);
  cdsCadPag.Open;
  TFloatField(cdsCadPag.FieldByName('fltValDup')).DisplayFormat := ',#0.00';
  dtsCadPag.DataSet := cdsCadPag;

  edtValor.Text := FormatFloat(',#0.00', cdsCadPag.Current<TCadPag>.fltValDup);

  grdDuplicDados.ApplyBestFit;

  pValidaParcelas;
end;

procedure TfrmCadCtaPagarParcelas.pValidaParcelas;
  Var
    fltValDup: Double;
    strChave: String;
begin
  fltValDup := 0;
  blnAltPar := (cdsCadPag.RecordCount > 1);

  If Not blnAltPar Then
  Begin
    pMensagemOK('Esta duplicata possui somente uma parcela!');
    Exit;
  End;

  Screen.Cursor := crHourGlass;
  cdsCadPag.DisableControls;
  Try
    cdsCadPag.First;
    While Not cdsCadPag.Eof Do
    Begin
      If cdsCadPag.Current<TCadPag>.strAutInc <> strAutoincAtual Then
      Begin
        strChave := 'CADPAG' + cdsCadPag.Current<TCadPag>.strAutInc;

        If Not fLockParcela(strChave) Then
        Begin
          fMensagem('ATENÇÃO!', 'A duplicata "'+ cdsCadPag.Current<TCadPag>.strNumDup + cdsCadPag.Current<TCadPag>.strParcel +
                    '" está sendo utilizada por outra estação: ' + fGetHostLock(strChave), ['&Ok']);
          blnAltPar := False;
          Exit;
        End;
      End;

      blnAltPar := blnAltPar And cdsCadPag.Current<TCadPag>.dtaDtaBai.IsNull;
      fltValDup := fltValDup + cdsCadPag.Current<TCadPag>.fltValDup;

      cdsCadPag.Next;
    End;
  Finally
    cdsCadPag.First;
    cdsCadPag.EnableControls;
    Screen.Cursor := crDefault;
  End;

  edtQtdPar.Text := '(' + cdsCadPag.RecordCount.ToString + ')';
  edtValTot.Text := FormatFloat(',#0.00', fltValDup);

  If fltTotVen = 0 Then
    fltTotVen := fltValDup;

  If Not blnAltPar Then
    pMensagemOK('Não será possível utilizar essa função pois a venda possui títulos já baixados.');
end;

function TfrmCadCtaPagarParcelas.fLockParcela(const strChave: String): Boolean;
begin
  If Not MatchStr(strChave, arrLockParc) Then
  Begin
    Result := fLock_Unlock(strChave, True, False);

    If Result Then
    Begin
      //armazena em array para liberar depois
      SetLength(arrLockParc, Length(arrLockParc) +1);
      arrLockParc[Length(arrLockParc) -1] := strChave;
    End;
  End
  Else
    Result := True;
end;

procedure TfrmCadCtaPagarParcelas.pUnlockParcelas;
  Var
    strChave: String;
begin
  Screen.Cursor := crHourGlass;
  Try
    For strChave In arrLockParc Do
    Begin
      fLock_Unlock(strChave, False);
    End;
  Finally
    Screen.Cursor := crDefault;
  End;
end;

end.
