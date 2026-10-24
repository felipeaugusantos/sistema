unit ContaPagar.TFrameCtaPagar;

interface

uses
  Classes, Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, frxClass, untTypesSistema, Data.DB,
  Vcl.DBCtrls, ComboBoxFocus, untPortadorFornecedor, System.StrUtils;

  Type
    TFrameContaPagar = class

    private

      FobjCodigo_Evento            :TEditFocus;
      FobjDescricao_Evento         :TEditFocus;
      FobjCodigo_Conta             :TMaskEdit;
      FobjNome_Conta               :TEditFocus;
      FobjQryConCnd                :TUniQuery;
      FobjQryCadCta                :TUniQuery;
      FobjQryCadEve                :TUniQuery;
      FobjVeio_Boleto              :TEditFocus;
      FobjVeio_Nota_Fiscal         :TEditFocus;
      FobjUsa_Cheque               :TEditFocus;
      FobjPrevisao                 :TEditFocus;
      FobjDeposito                 :TEditFocus;
      FobjUsoConsumo               :TEditFocus;
      FobjPagamentoAntecipado      :TEditFocus;
      FobjCompet                   :TMaskEditFocus;
      FDataDocumento               :String;

      FstrCodigo_Fornecedor        :String;
      FstrBanco_Fornecedor         :String;
      FobjLcbGuiaTributo           :TDBLookupComboBox;
      FobjLcbTipoTributo           :TDBLookupComboBox;
      FobjTipo_Documento           :TEditFocus;
      FobjLblTipo_Documento        :TLabel;
      FobjSpbDica_Tributo          :TSpeedButton;
      FobjLblGuia_Tributo          :TLabel;
      FstrTipo_Baixa               :String;
      FblnHabilitaTipoDocumento    :Boolean;
      FobjCbxBanco_Fornecedor      :TComboBoxFocus;
      FlstBcoFor                   :TStringList;
      FobjQryGuiaTributo           :TUniQuery;
      FobjQryTipoTributo           :TUniQuery;
      FobjDtsGuiaTributo           :TDataSource;
      FobjDtsTipoTributo           :TDataSource;

      procedure pPosicionaContaFornecedor;Overload;
      procedure CarregaTipoTributos(DataSet: TDataSet);


    public
      InclusaoManual: Boolean;
      property objCodigo_Evento: TEditFocus            read FobjCodigo_Evento             write FobjCodigo_Evento;
      property objDescricao_Evento: TEditFocus         read FobjDescricao_Evento          write FobjDescricao_Evento;
      property objCodigo_Conta: TMaskEdit              read FobjCodigo_Conta              write FobjCodigo_Conta;
      property objNome_Conta: TEditFocus               read FobjNome_Conta                write FobjNome_Conta;
      property objQryConCnd: TUniQuery                 read FobjQryConCnd                 write FobjQryConCnd;
      property objQryCadCta: TUniQuery                 read FobjQryCadCta                 write FobjQryCadCta;
      property objQryCadEve: TUniQuery                 read FobjQryCadEve                 write FobjQryCadEve;
      property objVeio_Boleto: TEditFocus              read FobjVeio_Boleto               write FobjVeio_Boleto;
      property objVeio_Nota_Fiscal: TEditFocus         read FobjVeio_Nota_Fiscal          write FobjVeio_Nota_Fiscal;
      property objUsa_Cheque: TEditFocus               read FobjUsa_Cheque                write FobjUsa_Cheque;
      property objPrevisao: TEditFocus                 read FobjPrevisao                  write FobjPrevisao;
      property objDeposito: TEditFocus                 read FobjDeposito                  write FobjDeposito;
      property objUsoConsumo :TEditFocus               read FobjUsoConsumo                write FobjUsoConsumo;
      property objPagamentoAntecipado :TEditFocus      read FobjPagamentoAntecipado       write FobjPagamentoAntecipado;
      property objCompet :TMaskEditFocus               read FobjCompet                    write FobjCompet;

      property strCodigo_Fornecedor: String            read FstrCodigo_Fornecedor         write FstrCodigo_Fornecedor;
      property strBanco_Fornecedor: String             read FstrBanco_Fornecedor          write FstrBanco_Fornecedor;
      property objQryGuiaTributo:TUniQuery             read FobjQryGuiaTributo            write FobjQryGuiaTributo;
      property objQryTipoTributo:TUniQuery             read FobjQryTipoTributo            write FobjQryTipoTributo;
      property objDtsGuiaTributo:TDataSource           read FobjDtsGuiaTributo            write FobjDtsGuiaTributo;
      property objDtsTipoTributo:TDataSource           read FobjDtsTipoTributo            write FobjDtsTipoTributo;
      property objLcbGuiaTributo:TDBLookupComboBox     read FobjLcbGuiaTributo            write FobjLcbGuiaTributo;
      property objLcbTipoTributo:TDBLookupComboBox     read FobjLcbTipoTributo            write FobjLcbTipoTributo;
      property objTipo_Documento: TEditFocus           read FobjTipo_Documento            write FobjTipo_Documento;
      property objLblTipo_Documento: TLabel            read FobjLblTipo_Documento         write FobjLblTipo_Documento;
      property objSpbDica_Tributo: TSpeedButton        read FobjSpbDica_Tributo           write FobjSpbDica_Tributo;
      property objLblGuia_Tributo: TLabel              read FobjLblGuia_Tributo           write FobjLblGuia_Tributo;
      property strTipo_Baixa: String                   read FstrTipo_Baixa                write FstrTipo_Baixa;
      property blnHabilitaTipoDocumento: Boolean       read FblnHabilitaTipoDocumento     write FblnHabilitaTipoDocumento;
      property objCbxBanco_Fornecedor: TComboBoxFocus  read FobjCbxBanco_Fornecedor       write FobjCbxBanco_Fornecedor;
      property strDataDocumento: String                read FDataDocumento          write FDataDocumento;

      Constructor Create;
      Destructor Destroy; override;

      procedure pValidaCentroCusto;
      procedure pValidaContaCusto;
      procedure pValidaVeioNF;
      procedure pValidaVeioBO;
      procedure pValidaUsaChe;
      procedure pValidaDeposito;
      procedure pValidaPrevisao;
      procedure pValidaPagamentoAntecipado;
      procedure pValidaUsoConsumo;
      procedure pValidaCompetencia;
      procedure pValidaTipoDocumento(out strTipoDoc: String);
      procedure pValidaGuiaTributo;
      procedure pValidaTipoTributo;
      procedure pCarregaCentroCusto;
      procedure pCarregaEvento;
      procedure pCarregaGuiasETributos(ATrazTributo: Boolean = False;
                                       AFilterGuias: String  = '';
                                       ADare : Boolean = False);

      procedure pChamaEventoSairComponenteGuiaTributo;
      procedure pHabilitaDesabilitaCampos;
      procedure pCarregaValoresPadroes;
      procedure pCarregaDadosBancariosFornecedor;
      procedure pSetaBcoFor(out strBcoFor: String);
      procedure pTrataBcoFor;
      procedure pValidaKeyValueLcbGuiatributo; 

      function fRetornaMsgValidaSN(objEditFocus: TEditFocus): String;
      procedure pPosicionaContaFornecedor(ABcoFor : String);Overload;

  End;

  CONST
    SQL_GUIA_TRIBUTO = 'SELECT GUI_CODGUI, GUI_DESCRI FROM GUITRI ';
    SQL_GUIA_TRIBUTO_WHERE_IN = 'SELECT GUI_CODGUI, GUI_DESCRI FROM GUITRI WHERE GUI_CODGUI IN';
    SQL_GUIA_TRIBUTO_DARE_WHERE_IN = 'SELECT GUI_CODGUI, IF(GUI_DESCRI LIKE "%GNRE%", REPLACE (GUI_DESCRI,"GNRE","DARE"),GUI_DESCRI) AS GUI_DESCRI FROM GUITRI WHERE GUI_CODGUI IN';
    SQL_TIPO_TRIBUTO = 'SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI FROM TIPTRI';
    SQL_TIPO_TRIBUTO_WHERE = 'WHERE TRI_CODGUI = :CODGUI';
    SQL_TIPO_TRIBUTO_WHERE_FALSE = 'WHERE FALSE';
    SQL_DADOS_BANCARIO_FORNECEDOR = 'SELECT B.AUTOINCREM, ' +
            'CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ' +
            '"AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ' +
            '"CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA), 14, " ")) AS DESC_CONTA ' +
            'FROM BCOFOR B WHERE B.BCF_CODFOR = :CODFOR ' +
            'ORDER BY B.AUTOINCREM DESC';

implementation

uses untFuncoesSimples, untFuncoes, untPesqAux, untCadCta;

{ TFrameContaPagar }


procedure TFrameContaPagar.CarregaTipoTributos(DataSet: TDataSet);
begin
  pChamaEventoSairComponenteGuiaTributo;
end;

constructor TFrameContaPagar.Create;
begin
  FobjCodigo_Evento        := Nil;
  FobjDescricao_Evento     := Nil;
  FobjCodigo_Conta         := Nil;
  FobjNome_Conta           := Nil;
  FobjQryConCnd            := Nil;
  FobjQryCadCta            := Nil;
  FobjQryCadEve            := Nil;
  FobjVeio_Nota_Fiscal     := Nil;
  FobjUsa_Cheque           := Nil;
  FobjPrevisao             := Nil;
  FobjPagamentoAntecipado  := Nil;
  FobjCompet               := Nil;
  FobjUsoConsumo           := Nil;
  FobjLcbGuiaTributo       := Nil;
  FobjLcbTipoTributo       := Nil;
  FstrCodigo_Fornecedor    := '';
  FstrBanco_Fornecedor     := '';
  FobjTipo_Documento       := Nil;
  FobjLblTipo_Documento    := Nil;
  FobjSpbDica_Tributo      := Nil;
  FobjLblGuia_Tributo      := Nil;
  FstrTipo_Baixa           := '';
  FblnHabilitaTipoDocumento:= True;
  FobjCbxBanco_Fornecedor  := Nil;
  FlstBcoFor               := TStringList.Create;
  FobjQryGuiaTributo       := fCriaQuery;
  FobjQryGuiaTributo.AfterScroll := CarregaTipoTributos;
  FobjQryTipoTributo       := fCriaQuery;
  FobjDtsGuiaTributo       := fCriaDataSource(FobjQryGuiaTributo);
  FobjDtsTipoTributo       := fCriaDataSource(FobjQryTipoTributo);
end;

destructor TFrameContaPagar.Destroy;
begin
  If AsSigned(FlstBcoFor) Then
    FreeAndNil(FlstBcoFor);

  If AsSigned(FobjDtsGuiaTributo) Then
    FreeAndNil(FobjDtsGuiaTributo);

  If AsSigned(FobjDtsTipoTributo) Then
    FreeAndNil(FobjDtsTipoTributo);


  If AsSigned(FobjQryGuiaTributo) then
    FreeAndNil(FobjQryGuiaTributo);

  If AsSigned(FobjQryTipoTributo) Then
    FreeAndNil(FobjQryTipoTributo);
end;

function TFrameContaPagar.fRetornaMsgValidaSN(objEditFocus: TEditFocus): String;
begin
  If Pos(objEditFocus.Text, 'SN') <= 0 Then
  Begin
    Result:= 'O campo deve ser informado com (S)im ou (N)ão!';
    pSetFocus(objEditFocus);
  End;
end;


procedure TFrameContaPagar.pCarregaCentroCusto;
begin
  If Not Assigned(FobjQryCadCta) Then
    FobjQryCadCta := fCriaQuery(Nil);

  FobjCodigo_Conta.Text := IIF(fEmptyStr(FobjCodigo_Conta.Text),FobjCodigo_Conta.Text,fGetPlanoDeContas(FobjCodigo_Conta.Text));

  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(FobjQryCadCta, FobjQryCadCta, FobjCodigo_Conta.Text)
  Else
    pPesquisaCadCta(FobjQryCadCta, FobjQryCadCta, FobjCodigo_Conta.Text, True, FstrCodigo_Fornecedor);

  If FobjCodigo_Conta.Text <> '' Then
    FobjNome_Conta.Text := FobjQryCadCta.FieldByName('CTA_DESCTA').AsString;

  If (Length(Trim(FobjCodigo_Conta.Text)) < 7) Then
    FobjCodigo_Conta.EditMask := ''
  Else
    FobjCodigo_Conta.EditMask := '99.99.999;0;_'
end;

procedure TFrameContaPagar.pCarregaEvento;
begin
  If Not Assigned(FobjQryCadEve) Then
    FobjQryCadEve := fCriaQuery(Nil);

  pPesquisaCadEve(FobjQryCadEve, FobjQryCadEve, FobjCodigo_Evento.Text);
  If FobjCodigo_Evento.Text <> '' Then
    FobjDescricao_Evento.Text := FobjQryCadEve.FieldByName('EVE_DESEVE').AsString;
end;


procedure TFrameContaPagar.pCarregaDadosBancariosFornecedor;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    FobjCbxBanco_Fornecedor.Clear;
    FlstBcoFor.Clear;

    qryGen.SQL.Clear;
    qryGen.SQL.Add(SQL_DADOS_BANCARIO_FORNECEDOR);
    qryGen.ParamByName('CODFOR').AsString := FstrCodigo_Fornecedor;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      FobjCbxBanco_Fornecedor.Items.Add(Trim(qryGen.FieldByName('DESC_CONTA').AsString));
      FlstBcoFor.Add(qryGen.FieldByName('AUTOINCREM').AsString);
      qryGen.Next;
    End;

    qryGen.Close;
  Finally
    pPosicionaContaFornecedor;

    pTrataBcoFor;
    FreeAndNil(qryGen);
  End;
end;

procedure TFrameContaPagar.pPosicionaContaFornecedor;
begin
  FobjCbxBanco_Fornecedor.ItemIndex := FlstBcoFor.IndexOf(FstrCodigo_Fornecedor);
end;

procedure TFrameContaPagar.pTrataBcoFor;
begin

  FobjCbxBanco_Fornecedor.Enabled := (FobjDeposito.Text = 'S');
  If (Not FobjCbxBanco_Fornecedor.Enabled) Then
  Begin
    FobjCbxBanco_Fornecedor.ItemIndex := -1;
  End;

end;

procedure TFrameContaPagar.pCarregaGuiasETributos(ATrazTributo: Boolean = False;
                                                  AFilterGuias: String  = '';
                                                  ADare : Boolean = False);
  Var
    FSQL_Guia : String;
begin
  FSQL_Guia := SQL_GUIA_TRIBUTO;

  // Utilizar quando não quiser exibir todas as Guias
  If Not fEmptyStr(AFilterGuias) Then
  Begin
    If ADare Then
      FSQL_Guia := SQL_GUIA_TRIBUTO_DARE_WHERE_IN + '('+ fRetStrToSQLIn(AFilterGuias,'_')+')'
    Else
      FSQL_Guia := SQL_GUIA_TRIBUTO_WHERE_IN + '('+ fRetStrToSQLIn(AFilterGuias,'_')+')';
  End;

  FobjQryGuiaTributo.Close;
  FobjQryGuiaTributo.SQL.Clear;
  FobjQryGuiaTributo.SQL.Add(FSQL_Guia);
  FobjQryGuiaTributo.Open;

  FobjQryTipoTributo.Close;
  FobjQryTipoTributo.SQL.Clear;
  FobjQryTipoTributo.SQL.Add(SQL_TIPO_TRIBUTO);

  if ATrazTributo then
  begin
    FobjQryTipoTributo.SQL.Add(SQL_TIPO_TRIBUTO_WHERE);
    FobjQryTipoTributo.ParamByName('CODGUI').AsInteger := FobjQryGuiaTributo.FieldByName('GUI_CODGUI').AsInteger;
  end
  else
    FobjQryTipoTributo.SQL.Add(SQL_TIPO_TRIBUTO_WHERE_FALSE);

  FobjQryTipoTributo.Open;

  FobjLcbGuiaTributo.ListSource:= FobjDtsGuiaTributo;
  FobjLcbTipoTributo.ListSource:= FobjDtsTipoTributo;

end;

procedure TFrameContaPagar.pChamaEventoSairComponenteGuiaTributo;
begin
  If (VarToStr(FobjLcbGuiaTributo.KeyValue) <> '') And
     (FobjLcbGuiaTributo.KeyValue > 0) then
  Begin
    FobjQryTipoTributo.Close;
    FobjQryTipoTributo.SQL.Clear;
    FobjQryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
    FobjQryTipoTributo.SQL.Add('FROM TIPTRI ');
    FobjQryTipoTributo.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
    FobjQryTipoTributo.ParamByName('CODGUI').AsInteger := FobjLcbGuiaTributo.KeyValue;
    FobjQryTipoTributo.Open;
  End;

  FobjLcbTipoTributo.Enabled := FobjQryTipoTributo.RecordCount > 0;

end;

procedure TFrameContaPagar.pHabilitaDesabilitaCampos;
begin
  FobjTipo_Documento.Enabled    := FblnHabilitaTipoDocumento;
  FobjLblTipo_Documento.Enabled := FblnHabilitaTipoDocumento;
end;

procedure TFrameContaPagar.pPosicionaContaFornecedor(ABcoFor: String);
begin
  If fEmptyStr(ABcoFor) Then Exit;
  FobjCbxBanco_Fornecedor.ItemIndex := FlstBcoFor.IndexOf(ABcoFor);
end;

procedure TFrameContaPagar.pSetaBcoFor(out strBcoFor: String);
begin
  If FobjCbxBanco_Fornecedor.ItemIndex > -1 Then
    strBcoFor := FlstBcoFor[FobjCbxBanco_Fornecedor.ItemIndex]
  Else
    strBcoFor := '';
end;


procedure TFrameContaPagar.pValidaCentroCusto;
begin

  If Not fEmptyStr(FobjCodigo_Evento.Text) Then
  Begin
    FobjDescricao_Evento.Text := fRetNomEvento(FobjCodigo_Evento);

    If fEmptyStr(FobjDescricao_Evento.Text) Then
    Begin
      Raise Exception.Create('Esse Centro de Custos não está cadastrado!');
    End;

  End
  Else
  Begin
    If (fCfgSis('CTPOBE', varBoolean)) Then
    Begin
      Raise Exception.Create('O Centro de Custos deve ser preenchido!');
      psetFocus(FobjCodigo_Evento);
    End;
    FobjCodigo_Evento.Clear;
    FobjDescricao_Evento.Clear;
  End;

end;

procedure TFrameContaPagar.pValidaUsaChe;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjUsa_Cheque);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjVeio_Boleto);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjDeposito);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  If (FobjUsa_Cheque.Text = 'S') Then
  Begin
    If (FobjVeio_Boleto.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar cheque como (S)im, os campos deposito e veio boleto devem estar iguais à (N)ão!');
      Exit;
    End;

    If (FobjDeposito.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar cheque como (S)im, os campos deposito e veio boleto devem estar iguais à (N)ão!');
      Exit;
    End;
  End;

end;

procedure TFrameContaPagar.pValidaUsoConsumo;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjUsoConsumo);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
  End
end;

procedure TFrameContaPagar.pValidaVeioBO;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjVeio_Boleto);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjUsa_Cheque);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjDeposito);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  If FobjVeio_Boleto.Text = 'S' Then
  Begin
    If (FobjUsa_Cheque.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar veio boleto como (S)im, os campos deposito e cheque devem estar iguais à (N)ão!');
    End;

    If (FobjDeposito.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar veio boleto como (S)im, os campos deposito e cheque devem estar iguais à (N)ão!');
    End;

  End;

end;

procedure TFrameContaPagar.pValidaDeposito;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjDeposito);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjUsa_Cheque);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  strMsg:= fRetornaMsgValidaSN(FobjVeio_Boleto);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
    Exit;
  End;

  If FobjDeposito.Text = 'S' then
  Begin
    If (FobjUsa_Cheque.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar deposito como (S)im, os campos veio boleto e cheque devem estar iguais à (N)ão!');
    End;

    If (FobjVeio_Boleto.Text = 'S') Then
    Begin
      Raise Exception.Create('Para informar deposito como (S)im, os campos veio boleto e cheque devem estar iguais à (N)ão!');
    End;

  End;
end;


procedure TFrameContaPagar.pValidaVeioNF;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjVeio_Nota_Fiscal);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
  End;
end;

procedure TFrameContaPagar.pValidaCompetencia;
begin
  If not fValidaDataStr('01/'+ FobjCompet.Text) Then
  Begin
    Raise Exception.Create('Data informada na Competência não é válida!');
  end

  Else If fEmptyStr(fTiraCaracEspeciais(FobjCompet.Text)) Then
  Begin
    Raise Exception.Create('A Competência deve ser preenchida!');
  End

  Else If Length(fTiraCaracEspeciais(Trim(FobjCompet.Text))) < 6 Then
  Begin
    Raise Exception.Create('O ano da Competência deve ser preenchido com 4 dígitos!');
  End

end;

procedure TFrameContaPagar.pValidaContaCusto;
begin
  If fEmptyStr(fTiraCaracEspeciais(FobjCodigo_Conta.Text)) Then
  Begin
    Raise Exception.Create('O Plano de Contas deve ser preenchido!');
  End
  Else
  Begin
    pCarregaCentroCusto;
    If FobjQryCadCta.FieldByName('CTA_CODCTA').IsNull Then
    Begin
      If Not fCfgSis('USACTF', varBoolean) Then
      Begin
        Raise Exception.Create('Esse Centro de Custo não está cadastrado!');
      End
      Else
      Begin
        Raise Exception.Create('Esse Centro de Custo não está cadastrado ou não está vinculado ao fornecedor!');
      End;
    End
    Else If Not fValidaLinhaGrupoCadCta(FobjCodigo_Conta.Text) Then
    Begin
      Raise Exception.Create('Linha / Grupo não permitido!');
    End
    Else If Not PlanoDeContasAtivo(FobjCodigo_Conta.Text) Then
      Raise Exception.Create('Preencha um Plano de Contas válido!');
  End;
end;

procedure TFrameContaPagar.pValidaPagamentoAntecipado;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjPagamentoAntecipado);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
  End;
end;

procedure TFrameContaPagar.pValidaPrevisao;
var
  strMsg: String;
begin
  strMsg:= fRetornaMsgValidaSN(FobjPrevisao);
  If strMsg <> '' Then
  Begin
    Raise Exception.Create(strMsg);
  End;
end;

procedure TFrameContaPagar.pValidaTipoDocumento(out strTipoDoc: String);
begin

  If (FobjTipo_Documento.Visible) Then
  Begin
    If (FobjTipo_Documento.Enabled) Then
    Begin
      If Not fEmptyStr(FobjTipo_Documento.Text) Then
      Begin
        If Pos(FobjTipo_Documento.Text,'1_2_3_') <= 0 Then
        Begin
          pSetFocus(FobjTipo_Documento);
          Raise Exception.Create('O Tipo do Documento deve ser 1, 2 ou 3!');
        End;

        If (FobjTipo_Documento.Text = '2') Then
        Begin
          FobjLcbGuiaTributo.Visible := True;
          FobjLcbTipoTributo.Visible := True;
          FobjSpbDica_Tributo.Visible := True;
          FobjLblGuia_Tributo.Visible := True;
          pSetFocus(FobjLcbGuiaTributo);
          strTipoDoc := '2';
        End
        Else
        Begin
          strTipoDoc := FobjTipo_Documento.Text;
          FobjLcbGuiaTributo.Visible := False;
          FobjLcbTipoTributo.Visible := False;
          FobjSpbDica_Tributo.Visible := False;
          FobjLcbGuiaTributo.KeyValue := -1;
          FobjLcbTipoTributo.KeyValue := -1;
          FobjLblGuia_Tributo.Visible := False;
        End;
      End;
    End;
  End;

end;

procedure TFrameContaPagar.pValidaGuiaTributo;
begin

  If (FobjTipo_Documento.Visible) Then
  Begin
    If (FobjTipo_Documento.Enabled) Then
    Begin
      If Not fEmptyStr(FobjTipo_Documento.Text) Then
      Begin
        If (FobjTipo_Documento.Text = '2') Then
        Begin
          FobjLcbGuiaTributo.Visible := True;
          FobjLcbTipoTributo.Visible := True;
          FobjSpbDica_Tributo.Visible := True;
          FobjLblGuia_Tributo.Visible := True;
        End
        Else
        Begin
          FobjLcbGuiaTributo.Visible := False;
          FobjLcbTipoTributo.Visible := False;
          FobjSpbDica_Tributo.Visible := False;
          FobjLcbGuiaTributo.KeyValue := -1;
          FobjLcbTipoTributo.KeyValue := -1;
          FobjLblGuia_Tributo.Visible := False;
        End;
      End;
    End;
  End;

end;

procedure TFrameContaPagar.pValidaKeyValueLcbGuiatributo;
Begin

  If (VarToString(FobjLcbGuiatributo.KeyValue) = '') Then
    If (FobjLcbGuiaTributo.KeyValue < 0 ) Then
      If (Not fEmptyStr(FobjLcbTipoTributo.Text)) Then
  Begin
    pSetFocus(FobjLcbGuiatributo);
    Raise Exception.Create('A descrição da guia deve ser informada. Verifique!');
  End;

End;

procedure TFrameContaPagar.pValidaTipoTributo;
begin
  If (FobjLcbGuiaTributo.Enabled) Then
  Begin
    If (VarToString(FobjLcbGuiaTributo.KeyValue) <> '') Then
     If (FobjLcbGuiatributo.KeyValue <> 8) Then //ISS
      If (FobjLcbGuiatributo.KeyValue <> 9) Then //IPTU
       If(fEmptyStr(FobjLcbTipoTributo.Text)) Then
    Begin
      pSetFocus(FobjLcbTipoTributo);
      Raise Exception.Create('O código de receita do tributo deve ser informado. Verifique!');
      Exit;
    End;
  End;

  Try
    pValidaKeyValueLcbGuiatributo
  Except
    on E: Exception do
    Begin
      pMensagemOk(E.Message);
      Exit;
    End;
  End;

  pSetFocus(FobjVeio_Boleto);
end;

procedure TFrameContaPagar.pCarregaValoresPadroes;
begin
  FobjVeio_Boleto.Text     := 'N';
  FobjVeio_Nota_Fiscal.Text:= IIF((fCfgSis('VEIONF', varString) <> 'B'),fCfgSis('VEIONF', varString),'');
  FobjUsa_Cheque.Text      := 'N';
  FobjPrevisao.Text        := 'N';
  FobjDeposito.Text        := 'N';
  FobjPrevisao.Text        := 'N';
  FobjUsoConsumo.Text      := 'N';
  FobjPagamentoAntecipado.Text := 'N';
  FobjCompet.Text          := FormatDateTime('mm/yyyy', StrToDateDef(strDataDocumento, fNow));
  if InclusaoManual then
  begin
    FobjVeio_Nota_Fiscal.Text := 'S';
    FobjTipo_Documento.Text := '1';
  end;

  pHabilitaDesabilitaCampos;
end;

{**********Units que utilizam este objeto********}
{untFiscCtpEntrada.pas
 untRcxDigPagamento.pas
 untRcxResumoCaixa.pas
}


end.
