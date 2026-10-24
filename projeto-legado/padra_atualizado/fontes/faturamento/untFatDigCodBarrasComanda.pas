unit untFatDigCodBarrasComanda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, untTypesSistema, Data.DB, MemDS, DBAccess, Uni, untLiberacao;

type
  TfrmFatDigCodBarrasComanda = class(TfrmPaiConfirma)
    pnlCodBarComanda: TPanel;
    lblCodBarComanda: TLabel;
    edtCodBarComanda: TEditFocus;
    btnGravarSemComanda: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarSemComandaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    blnGravarSemComanda : Boolean;
    objLiberacao : TLiberacao;

    {Documento}
    strNumDoc_Atual,
    strEspDoc_Atual,
    strCodEmp_Atual : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

    class function fDigCodBarrasComanda(strNumDoc, strEspDoc, strEmpDoc : String) : TComanda;

    function fComandaEmUso(var strNumDoc : String;
                           var strEspDoc : String;
                           var strCodEmp : String;
                               strBarCom : String) : Boolean;

    class function fRetComandaPDEmAberto(var strNumDoc : String;
                                         var strEspDoc : String;
                                         var strCodEmp : String) : String;

    class function fRetPDEmAberto_Comanda(strBarCom : String) : TDocumento;

    class function fComandaEstaDentroFaixa(strBarCom : String) : Boolean;

  end;

implementation

uses untFuncoesSimples, untFuncFat;

{$R *.dfm}

{ TfrmFatDigCodBarrasComanda }

procedure TfrmFatDigCodBarrasComanda.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnGravarSemComanda := False;
end;

procedure TfrmFatDigCodBarrasComanda.btnGravarSemComandaClick(Sender: TObject);
begin

  inherited;

  {Se o pedido já foi vinculado a uma comanda, se torna obrigatório sempre informar}
  if (fRetComandaPDEmAberto(strNumDoc_Atual, strEspDoc_Atual, strCodEmp_Atual) <> '') then
  begin
    fMensagem('Atenção', 'Este pedido já foi vinculado a uma comanda anteriormente!', ['&Ok']);
    Exit;
  end;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(63);
  objLiberacao.objMsgLibera.pAddTexto('GRAVAR SEM COMANDA');
  objLiberacao.objMsgLibera.pAddSeparador(63);
  objLiberacao.objMsgLibera.pAddTexto('Gravar inserção/alteração de "Pedido de Venda" sem uma comanda vinculada.');

  objLiberacao.strDirAce := 'SEMCOM';
  objLiberacao.strMsgSen := 'Gravar sem Comanda';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnSempreVariavelUsuario := True;


  blnGravarSemComanda := objLiberacao.fLibera;

end;

function TfrmFatDigCodBarrasComanda.fComandaEmUso(var strNumDoc : String;
                                                  var strEspDoc : String;
                                                  var strCodEmp : String;
                                                      strBarCom : String) : Boolean;
var
  qryAux : TUniQuery;
begin

  qryAux := fCriaQuery(nil);

  try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  FATGOR.FGO_NUMDOC,       ');
    qryAux.SQL.Add('  FATGOR.FGO_ESPDOC,       ');
    qryAux.SQL.Add('  FATGOR.FGO_CODEMP        ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  FATGOR                   ');
    qryAux.SQL.Add('  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  EXTGOR.FGO_BARCOM = ' + QuotedStr(strBarCom)    + ' AND ');
    qryAux.SQL.Add('  FATGOR.FGO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ');
    qryAux.SQL.Add('  (FATGOR.FGO_JAFATU <> 1) '); {Não faturado / Não baixado}
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin

      {Se for o documento atual retorna FALSE!}
      if (qryAux.FieldByName('FGO_NUMDOC').AsString = strNumDoc_Atual) and
         (qryAux.FieldByName('FGO_ESPDOC').AsString = strEspDoc_Atual) and
         (qryAux.FieldByName('FGO_CODEMP').AsString = strCodEmp_Atual) then
      begin
        strNumDoc := '';
        strEspDoc := '';
        strCodEmp := '';
        Result    := False;
      end
      else
      begin
        strNumDoc := qryAux.FieldByName('FGO_NUMDOC').AsString;
        strEspDoc := qryAux.FieldByName('FGO_ESPDOC').AsString;
        strCodEmp := qryAux.FieldByName('FGO_CODEMP').AsString;
        Result    := True;
      end;

    end
    else
    begin
      strNumDoc := '';
      strEspDoc := '';
      strCodEmp := '';
      Result    := False;
    end;

  finally
    FreeAndNil(qryAux);
  end;

end;

class function TfrmFatDigCodBarrasComanda.fComandaEstaDentroFaixa(strBarCom: String): Boolean;
begin

  Result := True;

  if not fEmptyStr(strBarCom) then
  begin
    if (StrToIntDef(strBarCom, 0) < StrToIntDef(fCfgSis('COMINI'), 0)) or
       (StrToIntDef(strBarCom, 0) > StrToIntDef(fCfgSis('COMFIN'), 0)) then
      Result := False;
  end;

end;

class function TfrmFatDigCodBarrasComanda.fDigCodBarrasComanda(strNumDoc, strEspDoc, strEmpDoc : String): TComanda;
var
  frmFatDigCodBarrasComanda : TfrmFatDigCodBarrasComanda;

  strEspDoc_,
  strNumDoc_,
  strCodEmp_,
  strBarCom,
  strBarComPD : String;

begin

  {Limpa record}
  Result.blnCancelaDig       := False;
  Result.blnResult           := False;
  Result.strCodComanda       := '';
  Result.blnEmUso            := False;
  Result.Documento.strNumDoc := '';
  Result.Documento.strEspDoc := '';
  Result.Documento.strCodEmp := '';
  Result.blnDif              := False;
  Result.strCodComPD         := '';

  frmFatDigCodBarrasComanda := TfrmFatDigCodBarrasComanda.Create(nil);

  {Armazena documento atual}
  frmFatDigCodBarrasComanda.strNumDoc_Atual := strNumDoc;
  frmFatDigCodBarrasComanda.strEspDoc_Atual := strEspDoc;
  frmFatDigCodBarrasComanda.strCodEmp_Atual := strEmpDoc;

  {Solicita o código de barras}
  frmFatDigCodBarrasComanda.ShowModal;

  if (frmFatDigCodBarrasComanda.ModalResult = mrOk) then
  begin

    {Formata código}
    strBarCom := fStrZero(frmFatDigCodBarrasComanda.edtCodBarComanda.Text, frmFatDigCodBarrasComanda.edtCodBarComanda.MaxLength);

    if (strBarCom = fStrZero('0', frmFatDigCodBarrasComanda.edtCodBarComanda.MaxLength)) then
      strBarCom := '';

    if not frmFatDigCodBarrasComanda.blnGravarSemComanda then
    begin

      {Verifica se comanda esta em uso}
      if not frmFatDigCodBarrasComanda.fComandaEmUso(strNumDoc_,
                                                     strEspDoc_,
                                                     strCodEmp_,
                                                     strBarCom) then
      begin

        if (frmFatDigCodBarrasComanda.strNumDoc_Atual <> '') and
           (frmFatDigCodBarrasComanda.strEspDoc_Atual <> '') and
           (frmFatDigCodBarrasComanda.strCodEmp_Atual <> '') then
          strBarComPD := fRetComandaPDEmAberto(frmFatDigCodBarrasComanda.strNumDoc_Atual,
                                               frmFatDigCodBarrasComanda.strEspDoc_Atual,
                                               frmFatDigCodBarrasComanda.strCodEmp_Atual);

        {Valida se comanda informada é diferente da viculada ao pedido caso houver!}
        if (not fEmptyStr(strBarComPD)) and (strBarComPD <> strBarCom) then
        begin
          Result.blnDif := True;
        end
        else
        begin
          Result.blnResult     := True;
          Result.strCodComanda := strBarCom;
        end;

      end
      else
      begin
        Result.blnEmUso            := True;
        Result.strCodComanda       := strBarCom;
        Result.Documento.strNumDoc := strNumDoc_;
        Result.Documento.strEspDoc := strEspDoc_;
        Result.Documento.strCodEmp := strCodEmp_;
      end;

    end
    else
    begin
      {Foi permitido gravar sem comanda!}
      Result.blnResult     := True;
      Result.strCodComanda := '';
    end;

  end
  else
  if (frmFatDigCodBarrasComanda.ModalResult = mrCancel) then
    Result.blnCancelaDig := True;

  FreeAndNil(frmFatDigCodBarrasComanda);

end;

procedure TfrmFatDigCodBarrasComanda.FormCreate(Sender: TObject);
begin
  inherited;
  blnGravarSemComanda := False;
  btnGravarSemComanda.Enabled := fVerificaAcessoSistema('SEMCOM');
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatDigCodBarrasComanda.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmFatDigCodBarrasComanda.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

class function TfrmFatDigCodBarrasComanda.fRetComandaPDEmAberto(var strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryAux : TUniQuery;
begin

  Result := '';

  qryAux := fCriaQuery(nil);

  try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT              ');
    qryAux.SQL.Add('  EXTGOR.FGO_BARCOM ');
    qryAux.SQL.Add('FROM                ');
    qryAux.SQL.Add('  FATGOR            ');
    qryAux.SQL.Add('  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryAux.SQL.Add('WHERE               ');
    qryAux.SQL.Add('  FATGOR.FGO_NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ');
    qryAux.SQL.Add('  FATGOR.FGO_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ');
    qryAux.SQL.Add('  FATGOR.FGO_CODEMP = ' + QuotedStr(strCodEmp) + ' AND ');
    qryAux.SQL.Add('  (EXTGOR.FGO_BARCOM <> "") AND ');
    qryAux.SQL.Add('  (FATGOR.FGO_JAFATU <> 1) '); {Não faturado / Não baixado}
    qryAux.Open;

    if not qryAux.IsEmpty then
      Result := qryAux.FieldByName('FGO_BARCOM').AsString;

  finally
    FreeAndNil(qryAux);
  end;

end;

class function TfrmFatDigCodBarrasComanda.fRetPDEmAberto_Comanda(strBarCom: String): TDocumento;
var
  qryAux : TUniQuery;
begin

  Result.strNumDoc := '';
  Result.strEspDoc := '';
  Result.strCodEmp := '';

  qryAux := fCriaQuery(nil);

  try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT              ');
    qryAux.SQL.Add('  FATGOR.FGO_NUMDOC,');
    qryAux.SQL.Add('  FATGOR.FGO_ESPDOC,');
    qryAux.SQL.Add('  FATGOR.FGO_CODEMP ');
    qryAux.SQL.Add('FROM                ');
    qryAux.SQL.Add('  FATGOR            ');
    qryAux.SQL.Add('  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryAux.SQL.Add('WHERE               ');
    qryAux.SQL.Add('  FATGOR.FGO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ');
    qryAux.SQL.Add('  EXTGOR.FGO_BARCOM = ' + QuotedStr(strBarCom));
    qryAux.SQL.Add('  AND (FATGOR.FGO_JAFATU <> 1) '); {Não faturado / Não baixado}

    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      Result.strNumDoc := qryAux.FieldByName('FGO_NUMDOC').AsString;
      Result.strEspDoc := qryAux.FieldByName('FGO_ESPDOC').AsString;
      Result.strCodEmp := qryAux.FieldByName('FGO_CODEMP').AsString;
    end;

  finally
    FreeAndNil(qryAux);
  end;

end;

function TfrmFatDigCodBarrasComanda.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin

    if (Sender = edtCodBarComanda) then
    begin

      if (not blnGravarSemComanda) then
      begin

        if fEmptyStr(edtCodBarComanda.Text) then
        begin
          fMensagem('Atenção', 'Código da comanda é obrigatório!', ['&Ok']);
          Result := False;
        end
        else
        begin

          {Valida faixa permitida!}
          if not fComandaEstaDentroFaixa(edtCodBarComanda.Text) then
          begin
            fMensagem('Atenção', 'Código da comanda esta fora da faixa permitida!', ['&Ok']);
            Result := False;
          end;

        end;

      end;

    end;

  end;

  if not Result then
    pSetFocus(Sender);

end;

end.
