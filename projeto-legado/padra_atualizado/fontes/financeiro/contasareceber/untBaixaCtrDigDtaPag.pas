unit untBaixaCtrDigDtaPag;

interface

uses
  Windows, Classes, Controls, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, MaskEditFocus, frxClass,
  frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient, UniClientDataSet,
  untTypesSistema,  untLiberacao,untMsgLiberacao,untTlogLibRec;

type
  TfrmBaixaCtrDigDtaPag = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label3: TLabel;
    mskDtaPag: TMaskEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    cdsCadRec_VerificaData: TUniClientDataSet;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FLiberouDataRetroativa : Boolean;
    strDtaAnt : String;
    blnLibRet : Boolean;
    FLiberacao : TLiberacao;
    FLogLibRec: TLogLibRec;
    function fLibBxRetroativaAcimaPermitidoCTR: Boolean;
    procedure pAddDuplicatas;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    dtaDtaPag : TDateTime;
    cdsDupSel: TUniClientDataSet;
    property LibDtaRet: Boolean read FLiberouDataRetroativa;
    property Liberacao: TLiberacao read FLiberacao;
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaCtrDigDtaPag }

procedure TfrmBaixaCtrDigDtaPag.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(mskDtaPag) Then
  Begin
    dtaDtaPag := StrToDate(mskDtaPag.Text);

    Self.Close;
  End;

end;

procedure TfrmBaixaCtrDigDtaPag.FormCreate(Sender: TObject);
begin
  inherited;
  FLiberacao := TLiberacao.Create;
  FLogLibRec := TLogLibRec.Create;
end;

procedure TfrmBaixaCtrDigDtaPag.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLiberacao);
  FreeAndNil(FLogLibRec);

  If Assigned(cdsDupSel) Then
  Begin
    cdsDupSel.Close;
    FreeAndNil(cdsDupSel);
  End;

  inherited;
end;

procedure TfrmBaixaCtrDigDtaPag.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    dtaDtaPag := 0;
end;

procedure TfrmBaixaCtrDigDtaPag.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaPag);
  FLiberouDataRetroativa := False;
  blnLibRet := False;
end;

function TfrmBaixaCtrDigDtaPag.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intRecNo : Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaPag) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaPag.Text)) Then
      Begin
        fMensagem('', 'Data de pagamento deve ser preenchida!', ['&OK']);
        Result := False;
        Exit;
      End
      Else
      If (Not fValidaDataStr(mskDtaPag.Text)) And (Result) Then
      Begin
        fMensagem('', mskDtaPag.Text + ' não é uma data válida!', ['&OK']);
        Result := False;
        Exit;
      End
      Else If (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAIATR', varInteger))) Then
      Begin
        fMensagem('','A data do pagamento não pode ser anterior ao número de dias configurado na "Qtd de dias para baixa atrasada"!', ['&OK']);
        Result := False;
        Exit;
      End;

      If (StrtoDate(mskDtaPag.Text) > VS_Date) And (Result) Then
      Begin
        fMensagem('', 'A data de pagamento não pode ser maior que a data atual!', ['&OK']);
        Result := False;
        Exit;
      End;

      If Result Then
      Begin
        With cdsCadRec_VerificaData Do
        Begin
          intRecNo := RecNo;
          First;
          while Not Eof Do
          begin
            if StrToDate(mskDtaPag.Text) < FieldByName('CTR_DTACAD').AsDateTime Then
            begin
              fMensagem('', 'A data de pagamento informada não pode ser menor que a data de cadastro.', ['&O k']);
              Result := False;
              Break;
            end;
            Next;
          end;
          RecNo := intRecNo;
        End;
      End;


      If (Result) And (Not fEmptyStr(fCfgSis('BAICRR')))  And
         (fCfgSis('BAICRR', VarInteger) > 0) And
         (StrToDateDef(mskDtaPag.Text,0) < (VS_Date - fCfgSis('BAICRR', varInteger))) Then
      Begin
        If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
          blnLibRet := False;

        If (Not blnLibRet) Then
        Begin
          if FLiberouDataRetroativa Then
            FLogLibRec.pRemoveTmpLogLib(cdsDupSel.FieldByName('NRODUP').AsString
                                       ,cdsDupSel.FieldByName('CTR_ESPDOC').AsString
                                       ,cdsDupSel.FieldByName('CTR_CODEMP').AsString);

          Result := fLibBxRetroativaAcimaPermitidoCTR;
          blnLibRet := Result;
          strDtaAnt := mskDtaPag.Text;
          FLiberouDataRetroativa := blnLibRet;
        End;
      End
      Else If (Result) And (StrToDateDef(mskDtaPag.Text,0) < VS_Date) And
          (Not fVerificaAcessoSistema('CTRDTARET', strLoginUsuarioLogado)) Then
      Begin
        If  StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaAnt,0) Then
          blnLibRet := False;

        if not blnLibRet then
        Begin
          if FLiberouDataRetroativa Then
            FLogLibRec.pRemoveTmpLogLib(cdsDupSel.FieldByName('NRODUP').AsString
                                       ,cdsDupSel.FieldByName('CTR_ESPDOC').AsString
                                       ,cdsDupSel.FieldByName('CTR_CODEMP').AsString);

          Result := fLibBxRetroativaAcimaPermitidoCTR;
          blnLibRet := Result;
          strDtaAnt := mskDtaPag.Text;
          FLiberouDataRetroativa := blnLibRet;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCtrDigDtaPag.pAddDuplicatas;
begin
  FLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
  FLiberacao.objMsgLibera.pAddTexto('|                                                  RESUMO DOS TÍTULOS SELECIONADOS                                         |');
  FLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
  FLiberacao.objMsgLibera.pAddTexto('| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
  FLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');

  With cdsDupSel Do
  Begin
    First;
    While Not Eof Do
    Begin
      FLiberacao.objMsgLibera.pAddTexto( '| ' + fPadR(FieldByName('NRODUP').AsString,12) +
                                                        FieldByName('PARDUP').AsString + '-' +
                                                        FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                                        FieldByName('CTR_CODEMP').AsString + ' | ' +
                                                  fPadR(FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                                  fPadL(FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

      FLiberacao.objMsgLibera.pAddSeparador(124);
      Next;
    End;
  End;
end;

function TfrmBaixaCtrDigDtaPag.fLibBxRetroativaAcimaPermitidoCTR: Boolean;
begin


  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER', alCentro, teAmbos, '', 124);
  FLiberacao.objMsgLibera.pAddSeparador(124);

  pAddDuplicatas;

  FLiberacao.objMsgLibera.pAddQuebra;

  cdsDupSel.First;

  FLiberacao.strDirAce := 'CTRDTARET';
  FLiberacao.strSenLib := '';
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;
  FLiberacao.strCodIte := cdsDupSel.FieldByName('AUTOINCREM').AsString;
  FLiberacao.strMsgSen := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER';
  FLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A RECEBER';

  Result := FLiberacao.fLibera;

  If Result Then
     FLogLibRec
      .pInsereLogLigTMP(FLiberacao
                          ,cdsDupSel.FieldByName('NRODUP').AsString
                          ,cdsDupSel.FieldByName('CTR_ESPDOC').AsString
                          ,cdsDupSel.FieldByName('CTR_CODEMP').AsString);
end;


end.
