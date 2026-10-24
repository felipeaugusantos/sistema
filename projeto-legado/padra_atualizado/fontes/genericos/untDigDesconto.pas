unit untDigDesconto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Math, BitBtnLockedIncrem, UntTypesSistema, UntFuncFat,
  frxClass, frxExportCSVTestabilidade, untLiberacao,
  untMsgLiberacao, UniClientDataSet, untFuncoesGenerica;

type
  TfrmDigDesconto = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtTotGer: TEditFocus;
    edtPorDes: TEditFocus;
    edtDesEsp: TEditFocus;
    edtTotLiq: TEditFocus;
    lblCliente: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDesEspExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fltDesAnt: Double;
    objLiberacao : TLiberacao;
    function fChamaSenhaVariavel(strMsg : String = '';
      strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = '';
      strOperador : String = ''; strNTrava : String = ''; strDirAceNv2: String = '';
      strSenLibNv2: String = ''; blnNivel2: Boolean = False): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnPermiteAcrescimo: Boolean;
    blnAgrDup: Boolean;
    cdsDupSel: TUniClientDataSet;
  end;

var
  frmDigDesconto: TfrmDigDesconto;

implementation

uses untfuncoesSimples, untConstantes;

function TfrmDigDesconto.fChamaSenhaVariavel(strMsg : String = '';
      strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = '';
      strOperador : String = ''; strNTrava : String = ''; strDirAceNv2: String = '';
      strSenLibNv2: String = ''; blnNivel2: Boolean = False): Boolean;
Var
  objTabela   : TRegistroMsgLiberaTabela;
  objLinha    : TLinhaMsgLibera;
  strDuplicata: String;
  strCodCli   : String;
  fltPerDes   : Double;
begin
  Result := True;
  
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto(strMsg);

    objLiberacao.strDirAce := strDirAce;
    objLiberacao.strSenLib := fCfgSis(strCfgSis);
    objLiberacao.strMsgSen := strMsgSen;
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strOperador;
    objLiberacao.strCodDig := strOperador;
    objLiberacao.strDirAceNv2 := strDirAceNv2;
    objLiberacao.strSenLibNv2 := strSenLibNv2;
    objLiberacao.blnNivel2 := blnNivel2;
    objLiberacao.objMsgLibera.strTitulo := strMsg;

    If (Assigned(cdsDupSel)) And (Not cdsDupSel.IsEmpty) Then
    Begin

      cdsDupSel.DisableControls;

      cdsDupSel.Filter := 'CTR_MARDES = ''M''';
      cdsDupSel.Filtered := True;

      cdsDupSel.First;

      strCodCli := cdsDupSel.FieldByName('CTR_CODCLI').AsString;

      While Not cdsDupSel.Eof Do
      Begin
        If (strCodCli <> cdsDupSel.FieldByName('CTR_CODCLI').AsString) Then
        Begin
          strCodCli := 'MAIS DE UM CLIENTE';
          Break;
        End;

        cdsDupSel.Next;
      End;

      If (cdsDupSel.RecordCount > 1) Then
        strDuplicata := 'MAIS DE UMA DUPLICATA'
      Else
        strDuplicata := cdsDupSel.FieldByName('CTR_NUMDUP').AsString;

      If (StrToFloat(edtPorDes.Text) > 0) Then
         fltPerDes := StrToFloat(edtPorDes.Text)
      Else
        fltPerDes := fFormataFloat((100 * fStrToFloat(edtDesEsp.Text)) / fStrToFloat(edtTotGer.Text), 2);

      objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'               , strDuplicata                                                                                 , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'          , edtTotGer.Text                                                                               , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor desconto concedido', FormatFloat('#,##0.00', fStrToFloat(edtTotGer.Text) - fStrToFloat(edtTotLiq.Text))           , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('% Desconto concedido'    , FormatFloat('#,##0.00', fltPerDes) + '%'                                                     , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor recebido'          , edtTotLiq.Text                                                                               , 25);

      If (strCodCli <> 'MAIS DE UM CLIENTE') Then
      Begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , strCodCli + ' - ' + fRetNomCliente(strCodCli)                                                , 25);
        objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'                , fFormataCpfCgc(fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), fSetaPais) , 25);
      End
      Else
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , strCodCli                                                                                    , 25);

      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto máximo permitido', FormatFloat('#,##0.00',fCfgSis('CTRDES', varDouble)) + '%'                                  , 25);

      objLiberacao.objMsgLibera.pAddQuebra;

      objLinha  := TLinhaMsgLibera.Create;

      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'NUM. DUPLICATA', 14 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'       , 8  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'EMPRESA'       , 7  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'EMISSÃO'       , 14 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VENCIMENTO'    , 14 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VLR. DPL'      , 18 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'VLR. JUROS'    , 18 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'VLR. CORRIGIDO', 18 , alDireita  , teAutcom);

      objTabela := TRegistroMsgLiberaTabela.Create;
      objTabela.lstLinhas.Add(objLinha);

      cdsDupSel.First;
      While Not cdsDupSel.Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;

        objLinha.pAddColuna('NUM. DUPLICATA', cdsDupSel.FieldByName('CTR_NUMDUP').AsString                                , 14 , alEsquerda );
        objLinha.pAddColuna('ESP'           , cdsDupSel.FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('CLIENTE'       , cdsDupSel.FieldByName('CTR_CODCLI').AsString                                , 8  , alCentro   );
        objLinha.pAddColuna('EMPRESA'       , cdsDupSel.FieldByName('CTR_CODEMP').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('EMISSÃO'       , FormatDatetime('dd/mm/yyyy',cdsDupSel.FieldByName('CTR_DTACAD').AsDatetime) , 14 , alCentro   );
        objLinha.pAddColuna('VENCIMENTO'    , FormatDatetime('dd/mm/yyyy',cdsDupSel.FieldByName('CTR_DTAVEN').AsDatetime) , 14 , alCentro   );
        objLinha.pAddColuna('VLR. DUPL'     , FormatFloat('0.00', cdsDupSel.FieldByName('CTR_VALDUP').AsFloat)            , 18 , alDireita  );
        objLinha.pAddColuna('VLR. JUROS'    , FormatFloat('0.00', cdsDupSel.FieldByName('CTR_JURATR').AsFloat)            , 18 , alDireita  );
        objLinha.pAddColuna('VLR. CORRIGIDO', FormatFloat('0.00', cdsDupSel.FieldByName('CTR_VALCOR').AsFloat)            , 18 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        cdsDupSel.Next;
      End;
      cdsDupSel.Filtered := False;
      cdsDupSel.EnableControls;
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    End;

    While (True) Do
    Begin
      If objLiberacao.fLibera Then

        Break

      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        end;
    End;
  Finally
    objLiberacao.Clear;
  End;

end;

function TfrmDigDesconto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtPorDes) Then
  Begin

    If fEmptyStr(edtPorDes.Text) Then
      edtPorDes.Text := '0,00'
    Else If (fStrToFloat(edtPorDes.Text) > 0.0) Or blnPermiteAcrescimo Then
      edtDesEsp.Text := FloatToStrF(fStrToFloat(edtTotGer.Text) * (fStrToFloat(edtPorDes.Text)/100.0), ffFixed, 12, 2);

  End
  Else If (Sender = edtDesEsp) Then
  Begin

    If fEmptyStr(edtDesEsp.Text) Then
      edtDesEsp.Text := '0,00';

    edtTotLiq.Text := FormatFloat('###,##0.00',fStrToFloat(edtTotGer.Text) - fStrToFloat(edtDesEsp.Text));
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{$R *.dfm}

procedure TfrmDigDesconto.btnConfirmaDadosClick(Sender: TObject);
  Var
    fltCtrDes: Double;
    fltCtrDe2: Double;
    fltDesPer: Double;
    fltDesPe2: Double;
    strSCtrDe: String;
begin
  If (blnAgrDup) Then
  Begin
    fltCtrDes := fCfgSis('CTRDES', varDouble);
    fltDesPer := (RoundTo(fStrToFloat(edtTotGer.Text), -2) * RoundTo(fltCtrDes, -2)) / 100;


    strSCtrDe := fCfgSis('SCTRDE', varString);
    fltCtrDe2 := fCfgSis('CTRDE2', varDouble);
    fltDesPe2 := (RoundTo(fStrToFloat(edtTotGer.Text), -2) * RoundTo(fltCtrDe2, -2)) / 100;

    If (RoundTo(fStrToFloat(edtDesEsp.Text), -2) > RoundTo(fltDesPer, -2)) And (RoundTo(fStrToFloat(edtDesEsp.Text), -2) <> (RoundTo(fltDesAnt, -2))) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do desconto é maior que o permitido.', ['&Ok']);
      If fEmptyStr(strSCtrDe) Then
      Begin
        Exit;
      End
      Else
      Begin
        If (Not fChamaSenhaVariavel('O valor do desconto é maior que o permitido.', 'CTRDESMAX',
           'SCTRDE', 'Desconto Máximo', strLoginUsuarioLogado, '', 'CTRDESMA2', fCfgSis('SCTRD2'),
           fltDesPe2 > RoundTo(fStrToFloat(edtDesEsp.Text), -2))) Then
          Exit
        Else
          fltDesAnt := RoundTo(fStrToFloat(edtDesEsp.Text), -2);
      End;
    End;
  End;

  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmDigDesconto.edtDesEspExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtDesEsp, True);
end;

procedure TfrmDigDesconto.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrCancel;
end;

procedure TfrmDigDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  blnPermiteAcrescimo := False;
  blnAgrDup := False;
  fltDesAnt := 0;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmDigDesconto.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;

end;

procedure TfrmDigDesconto.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtPorDes);
  
end;

end.

