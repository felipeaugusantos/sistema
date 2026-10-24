unit untGerImobilizado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus, Vcl.Mask,
  Uni, DB, MaskEditFocus, untConsultas, untTypesSistema,
  untFuncoesSimples, DateUtils;

type
  TfrmGerImobilizado = class(TfrmPai)
    pnlFundo: TPanel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    lblCodEmp: TLabel;
    mskDtaIni1: TMaskEditFocus;
    mskDtaFin1: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnGerar: TBitBtnLocked;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    strSqlImo, strMsgErr : String;
    arrEmpresa: TConsultasArray;
    QryImo, QryAjuIcm : TUniQuery;

    function fVerificaCadImo : Boolean;
    function fRetornaMesAno(ADtaBas : TDateTime) : String;
    procedure pLimparCampos;
    procedure pGeraImobilizado;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmGerImobilizado: TfrmGerImobilizado;

implementation

{$R *.dfm}

procedure TfrmGerImobilizado.pLimparCampos;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
end;

function TfrmGerImobilizado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtCodEmp Then
    Begin
      if fEmptyStr(edtCodEmp.Text) then
      begin
        fMensagem('','Código da empresa não informado.',['&O K']);
        Result := False;
      end
      else
      begin
        edtCodEmp.Text := fStrZero(edtCodEmp.Text,3);
        edtNomEmp.Text := fRetNomeEmpresa(fStrZero(edtCodEmp.Text,3));
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('','Código da empresa não encontrado.',['&O K']);
          Result := False;
        End;
      end;
    End
    Else
      If(StrToDate(mskDtaIni.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaIni.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If(StrToDate(mskDtaFin.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaFin.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;
      If Sender = mskDtaIni Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            fMensagem('','O período não deve ficar em branco!',['&O K'])
          Else
            fMensagem('','A data inicial deve ser preenchida!',['&O K']);
          Result := False;
        End;

      End

      Else If Sender = mskDtaFin Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('','A data final deve ser preenchida',['&O K']);
          Result := False;
        End
        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial não pode ser maior que a data final!',['&O K']);
          Result := False;
        End;
      End;
  End;
end;

function TfrmGerImobilizado.fVerificaCadImo : Boolean;
begin
  Result := True;
  strMsgErr := '';

  QryImo.Close;
  QryImo.Sql.Clear;
  QryImo.Sql.Add(strSqlImo);
  QryImo.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  QryImo.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  QryImo.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  QryImo.Open;

  if QryImo.RecordCount > 0 then
  begin
    strMsgErr := 'Efetuar configuração dos seguintes registros '+
                 'na tela IMOBILIZADO/PATRIMONIO'#13;
    QryImo.First;
    while not QryImo.Eof do
    begin
      if QryImo.Fieldbyname('CODAJU').AsString = '' then
      begin
        Result := False;
        strMsgErr := strMsgErr + QryImo.Fieldbyname('AMO_CODIMO').AsString + '; ';
      end;

      QryImo.Next;
    end;
  end
  else
  begin
    Result := False;
    strMsgErr := 'Não há registros no período informado';
  end;
end;

function TfrmGerImobilizado.fRetornaMesAno(ADtaBas : TDateTime) : String;
begin
  Result := fStrZero( MonthOf( ADtaBas ), 2 ) + '/' + fStrZero( YearOf( ADtaBas ), 4 );
end;

procedure TfrmGerImobilizado.pGeraImobilizado;
var
  strSqlInc,
  strAutoinc : String;
begin
  btnGerar.Enabled := False;

  Try
    QryImo.First;
    While not QryImo.eof do
    begin
      strSqlInc := 'INSERT INTO AJUICM ( '+
                   '  AUTOINCREM, '+
                   '  AJU_CODAJU, '+
                   '  AJU_CODEMP, '+
                   '  AJU_MESANO, '+
                   '  AJU_OBSERV, '+
                   '  AJU_VALAJU, '+
                   '  AJU_NUMNOT  '+
                   '  ) VALUES (  '+
                   '  :AUTOIN,    '+
                   '  :CODAJU,    '+
                   '  :CODEMP,    '+
                   '  :MESANO,    '+
                   '  :OBSERV,    '+
                   '  :VALAJU,    '+
                   '  ""          '+
                   '  ); ';

      strAutoinc := fRetAutoIncrem('AJUICM', edtCodEmp.Text);

      QryAjuIcm.Close;
      QryAjuIcm.Sql.clear;
      QryAjuIcm.Sql.Add(strSqlInc);
      QryAjuIcm.ParamByName('AUTOIN').AsString  := strAutoinc;
      QryAjuIcm.ParamByName('CODAJU').AsString  := QryImo.FieldbyName('CODAJU').AsString;
      QryAjuIcm.ParamByName('CODEMP').AsString  := edtCodEmp.Text;
      QryAjuIcm.ParamByName('MESANO').AsString  := fRetornaMesAno(QryImo.FieldbyName('AMO_DTABAS').AsDateTime);
      QryAjuIcm.ParamByName('OBSERV').AsString  := QryImo.FieldbyName('DESAJU').AsString;
      QryAjuIcm.ParamByName('VALAJU').AsFloat   := QryImo.FieldbyName('AMO_VLRDEP').AsFloat;
      QryAjuIcm.ExecSql;

      QryAjuIcm.Close;
      QryAjuIcm.Sql.clear;
      QryAjuIcm.Sql.Add('UPDATE CADIMO SET IMO_INCAJU = :AUTOIN WHERE AUTOINCREM = :INCAMO ');
      QryAjuIcm.ParamByName('AUTOIN').AsString  := strAutoinc;
      QryAjuIcm.ParamByName('INCAMO').AsString  := QryImo.FieldbyName('AUTOINCREM').AsString;;
      QryAjuIcm.ExecSql;

      QryImo.next;
    end;

    fMensagem('','Geração realizada com sucesso.',['&O K']);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmGerImobilizado.pGeraImobilizado');
  End;

  btnGerar.Enabled := True;
  pLimparCampos;
  pSetFocus(mskDtaIni);
end;

procedure TfrmGerImobilizado.btnGerarClick(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
  if not fValidaCampos(mskDtaIni) then
    Exit;
  if not fValidaCampos(mskDtaFin) then
    Exit;
  if not fValidaCampos(edtCodEmp) then
    Exit;
  
  If Not fVerificaCadImo Then
  Begin
    fMensagem('ATENÇÃO!', strMsgErr,['&OK']);

    Exit;
  End;

  pGeraImobilizado;
end;

procedure TfrmGerImobilizado.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp);
end;

procedure TfrmGerImobilizado.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, Nil, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerImobilizado.FormCreate(Sender: TObject);
begin
  inherited;

  QryImo := fCriaQuery;
  QryAjuIcm := fCriaQuery;
end;

procedure TfrmGerImobilizado.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(QryImo);
  FreeAndNil(QryAjuIcm);
end;

procedure TfrmGerImobilizado.FormShow(Sender: TObject);
begin
  inherited;

  strSqlImo := 'SELECT C.AUTOINCREM, '+
               '       I.AMO_CODIMO, '+
               '       I.AMO_DTABAS, '+
               '       I.AMO_VLRDEP, '+
               '       C.IMO_DESCRI, '+
               '       IFNULL(C.IMO_CODAJU, "") AS CODAJU, '+
               '       IFNULL(C.IMO_DESAJU, "") AS DESAJU '+
               '  FROM IMOAMO I '+
               '     INNER JOIN CADIMO C ON '+
               '       I.AMO_CODIMO = C.IMO_CODIMO '+
               '  WHERE I.AMO_DTABAS >= :DTAINI '+
               '    AND I.AMO_DTABAS <= :DTAFIN '+
               '    AND C.IMO_CODEMP = :CODEMP '+
               '    AND C.IMO_INCAJU IS NULL ';

  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

end.
