unit untClassPanelCx;

interface

Uses
  ExtCtrls, Forms, Controls, SysUtils, UniClientDataSet, Classes,
  Variants, DB, cxGridCustomTableView, cxGridDBTableView, Uni,
  MaskUtils, cxStyles, BitBtnLockedIncrem, Vcl.ImgList,
  cxGraphics, cxImageComboBox, untTypesSistema;

Type
  TAtualizaDados = procedure(blnProcessMessage: Boolean = True) Of Object;

  TFunctionTab = Function(cdsConsulta: TUniClientDataSet; DropControl: TControl): Boolean Of Object;

  TAfterScroll = Procedure(DataSet: TDataSet);

  TPanelCx = Class(TObject)
  private

  public
    blnItemDiferenteSimilar,
    blnConfirmaSimilar: Boolean;
    strSimilar: String;

    sltLista: TStringList;

    pgcDropControl: TControl;

    prcAtualizaDados: TAtualizaDados;

    fncTeclaTab: TFunctionTab;

    blnTemPan: Boolean;  // SE POSSUI UM PAINEL

    arrNomCam: Array Of String;
    arrRetCam: Array Of Variant;

    intAltTel: Integer;
    frmPanel: TForm;

    Constructor Create(blnComPan: Boolean = True); Reintroduce;

    Procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked); Virtual; Abstract;

    Procedure pKeyDown(var Key: Word; Shift: TShiftState); Virtual; Abstract;

    Procedure pRetornaValores(cdsConsulta: TUniClientDataSet);

  End;

  TprcDisplayText = procedure(Sender: TcxCustomGridTableItem;
                              ARecord: TcxCustomGridRecord;
                              var AText: string) Of Object;
  TRecMascara = Record
    strCodCam: String;
    prcDisTex: TprcDisplayText;
  End;

  TRecIndexCampo = Record
    strCodCam: String;
    intIndice: Integer;
  End;

  TArrRecMascara = Array Of TRecMascara;

  TArrRecIndexCampo = Array Of TRecIndexCampo;

  TRecSubConsulta = Record
    strAlias_,
    strSubSql,
    strCamFil: String;
  End;

  TArrRecSubConsulta = Array Of TRecSubConsulta;

  TRecConflitos = Record
    strNomCam,
    strCamNov: String;
  End;

  TArrRecConflitos = Array Of TRecConflitos;

  TRecFormatDecimais = Record
    strNomCam: String;
    intQtdDec: Integer;
  End;

  TArrRecFormatDecimais = Array Of TRecFormatDecimais;

  TarrCampos = Array Of String;

  TRecFiltros = Record
    strNomCam,
    strInfCam: String;
  End;

  TarrFiltros = Array Of TRecFiltros;

  TRecLocalizar = Record
    strNomCam,
    strValCam: String;
  End;

  TRecIco = Record
    strNomCam: String;
    intValCam: Integer;
    intImaInd: Integer;
  End;

  TarrRecIcos = Array Of TRecIco;

  TDefConsulta = Class(TObject)
  private
    procedure pIncluiIdxCampo(strNomCam: String);

    procedure pIncluiCampos(arrCampos: Array Of String;
                            Var arrMskCam: TarrCampos);

  public
    arrRecMas: TArrRecMascara;
    arrIdxCam: TArrRecIndexCampo;
    arrSubCon: TArrRecSubConsulta;
    arrForDec: TArrRecFormatDecimais;
    arrConfli: TarrRecConflitos;
    arrFiltro: TarrFiltros;
    arrRecIco: TarrRecIcos;

    recLocalizar: TRecLocalizar;

    strSQLRetorno: String;

    arrMskCep: TarrCampos;
    arrMskFon: TarrCampos;
    arrMskCnp: TarrCampos;
    arrSimNao: TStringArrayArray;

    Constructor Create; Reintroduce;

    Function fIdxCampo(strCodCam: String): Integer;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; virtual;

    function fCellBold(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): Boolean; virtual;

    procedure pIncluiDefMascara(strNomCam: String; prcDspTxt: TprcDisplayText);
    procedure pIncluiIndCampos(arrCampos: Array Of String);
    procedure pIncluiSubConsulta(strAlias, strSql: String; strCampoFiltro: String = '');
    procedure pIncluiCampoSimNao(strNomCam: String; arrDescricao: TarrCampos = Nil);

    procedure pIncluiIcone(strCampo: String; intValor, intImageIndex: Integer);

    procedure pFormataDecimal(strCampo: String; intDecimais: Integer);

    procedure pIncluiCamposCep(arrCampos: Array Of String);
    procedure pIncluiCamposFone(arrCampos: Array Of String);
    procedure pIncluiCamposCNPJ(arrCampos: Array Of String);

    procedure pIncluiFiltro(strCampo, strInfFiltro: String);

    procedure pParametriza(qryConsulta: TUniQuery); Virtual;

    procedure pIncluiConflito(strNomCam, strCamNov: String);

    procedure pConfiguraIcones(cxConsultaView: TcxGridDBTableView; cxImageList: TcxImageList);

    procedure pDisplayCep(
                Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                var AText: string);

    procedure pDisplayFone(
                Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                 var AText: string);

    procedure pDisplayData(
                Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                var AText: string);

    procedure pDisplayCNPJ(
                Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                var AText: string);
  End;


implementation

uses untFuncoesGenerica;

Constructor TDefConsulta.Create;
Begin
  Inherited Create;

  strSQLRetorno := '';

  SetLength(arrRecMas, 0);
  SetLength(arrIdxCam, 0);
  SetLength(arrSubCon, 0);
  SetLength(arrConfli, 0);
  SetLength(arrFiltro, 0);

  SetLength(arrForDec, 0);
  SetLength(arrMskCep, 0);
  SetLength(arrMskFon, 0);

  SetLength(arrRecIco, 0);
End;

procedure TDefConsulta.pParametriza(qryConsulta: TUniQuery);
Begin

End;

procedure TDefConsulta.pIncluiIcone(strCampo: String; intValor, intImageIndex: Integer);
Begin
  SetLength(arrRecIco, Succ(Length(arrRecIco)));
  With arrRecIco[High(arrRecIco)] Do
  Begin
    strNomCam := strCampo;
    intValCam := intvalor;
    intImaInd := intImageIndex;
  End;
End;

procedure TDefConsulta.pConfiguraIcones(cxConsultaView: TcxGridDBTableView; cxImageList: TcxImageList);
  Var
    intIndice: Integer;
    intIndice2: Integer;
    item: TcxImageComboBoxItem;
    coluna: TcxGridDBColumn;
Begin
  For intIndice := Low(arrRecIco) To High(arrRecIco) Do
  With arrRecIco[intIndice] Do
  Begin
    coluna := cxConsultaView.GetColumnByFieldName(strNomCam);

    If Assigned(coluna) Then
    With coluna Do
    begin
      Visible         := True;
      Width           := 25;
      Index           := 0;
      SortIndex       := -1;
      Options.Editing := False;

      If Not SameText(PropertiesClassName, 'TcxImageComboBoxProperties') Then
      Begin
        PropertiesClass := TcxImageComboBoxProperties;

        For intIndice2 := intIndice To High(arrRecIco) Do
        With TcxImageComboBoxProperties(Properties) Do
        Begin
          Images := cxImageList;
          item := Items.Add;
          item.ImageIndex := arrRecIco[intIndice2].intImaInd;
          item.Value      := arrRecIco[intIndice2].intValCam;

          If arrRecIco[intIndice2].strNomCam <> strNomCam Then
            Break;
        End;
      End;
    End;
  End;
End;

procedure TDefConsulta.pIncluiFiltro(strCampo, strInfFiltro: String);
Begin
  SetLength(arrFiltro, Succ(Length(arrFiltro)));
  With arrFiltro[High(arrFiltro)] Do
  Begin
    strNomCam := strCampo;
    strInfCam := strInfFiltro;
  End;
End;

procedure TDefConsulta.pFormataDecimal(strCampo: String; intDecimais: Integer);
Begin
  SetLength(arrForDec, Succ(Length(arrForDec)));
  With arrForDec[High(arrForDec)] Do
  Begin
    strNomCam := strCampo;
    intQtdDec := intDecimais;
  End;
End;

procedure TDefConsulta.pIncluiConflito(strNomCam, strCamNov: String);
Begin
  SetLength(arrConfli, Succ(Length(arrConfli)));
  arrConfli[High(arrConfli)].strNomCam := strNomCam;
  arrConfli[High(arrConfli)].strCamNov := strCamNov;
End;

Function TDefConsulta.fIdxCampo(strCodCam: String): Integer;
  Var
    intIndice: Integer;
Begin
  Result := 0;

  For intIndice := Low(arrIdxCam) To High(arrIdxCam) Do
    If SameText(arrIdxCam[intIndice].strCodCam, strCodCam) Then
    Begin
      Result := arrIdxCam[intIndice].intIndice;
      Break;
    End;
End;

procedure TDefConsulta.pIncluiIndCampos(arrCampos: Array Of String);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    pIncluiIdxCampo(arrCampos[intIndice]);
End;

procedure TDefConsulta.pIncluiIdxCampo(strNomCam: String);
Begin
  SetLength(arrIdxCam, Succ(Length(arrIdxCam)));
  With arrIdxCam[High(arrIdxCam)] Do
  Begin
    strCodCam := strNomCam;
    intIndice := 0;
  End;
End;

procedure TDefConsulta.pIncluiCampos(arrCampos: Array Of String;
                                     Var arrMskCam: TarrCampos);
  Var
    intIndice: Integer;
Begin
  SetLength(arrMskCam, Length(arrCampos));
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    arrMskCam[intIndice] := arrCampos[intIndice];
End;

procedure TDefConsulta.pIncluiCamposCep(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskCep);
End;

procedure TDefConsulta.pIncluiCamposFone(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskFon);
End;

procedure TDefConsulta.pIncluiCampoSimNao(strNomCam: String; arrDescricao: TarrCampos = Nil);
  Var
    intIndex: Integer;
begin
  If arrDescricao <> Nil Then
    intIndex := Length(arrDescricao) + 1
  Else
    intIndex := 1;

  SetLength(arrSimNao, Succ(Length(arrSimNao)), intIndex);
  arrSimNao[High(arrSimNao)][0] := strNomCam;

  For intIndex := Low(arrDescricao) To High(arrDescricao) Do
    arrSimNao[High(arrSimNao)][intIndex+1] := arrDescricao[intIndex];
end;

procedure TDefConsulta.pIncluiCamposCNPJ(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskCnp);
End;

procedure TDefConsulta.pIncluiSubConsulta(strAlias, strSql: String; strCampoFiltro: String = '');
Begin
  SetLength(arrSubCon, Succ(Length(arrSubCon)));
  With arrSubCon[High(arrSubCon)] Do
  Begin
    strAlias_ := strAlias;
    strSubSql := strSql;
    strCamFil := strCampoFiltro;
  End;
End;

procedure TDefConsulta.pIncluiDefMascara(strNomCam: String; prcDspTxt: TprcDisplayText);
Begin
  SetLength(arrRecMas, Succ(Length(arrRecMas)));
  With arrRecMas[High(arrRecMas)] Do
  Begin
    strCodCam := strNomCam;
    prcDisTex := prcDspTxt;
  End;
End;

procedure TDefConsulta.pDisplayCep(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99999-999;0;', AText)
end;

procedure TDefConsulta.pDisplayFone(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := fFormataFone(AText)
end;

function TDefConsulta.fCellBold(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): Boolean;
begin
  Result := False;
end;

//sobrescrever este metodo para definir o estilo das celulas (fonte, cor, etc...)
function TDefConsulta.fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
begin
  Result := nil;
end;

procedure TDefConsulta.pDisplayCNPJ(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
end;

procedure TDefConsulta.pDisplayData(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99/99/9999;0;', AText)
end;

Constructor TPanelCx.Create(blnComPan: Boolean = True);
Begin
  Inherited Create;

  prcAtualizaDados := Nil;
  fncTeclaTab      := Nil;
  SetLength(arrNomCam, 0);
  blnTemPan := blnComPan;
  strSimilar := '';
  sltLista   := Nil;
End;

Procedure TPanelCx.pRetornaValores(cdsConsulta: TUniClientDataSet);
  Var
    intIndice: Integer;
Begin
  If (Length(arrNomCam) > 0) And
     (Not cdsConsulta.IsEmpty) Then
  With cdsConsulta Do
  Begin
    SetLength(arrRetCam, Length(arrNomCam));

    For intIndice := Low(arrNomCam) To High(arrNomCam) Do
      arrRetCam[intIndice] := FieldByName(arrNomCam[intIndice]).Value;

  End
  Else
    arrRetCam := Nil;
End;

end.

