unit untPnlDadosNFCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, Uni, StrUtils,
  untTypesSistema, BitBtnLockedIncrem, cxProgressBar;

type
  TfrmPnlDadosNFCompra = class(TForm)
    Panel2: TPanel;
    btnItensComprados: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnItensCompradosClick(Sender: TObject);
  private
    { Private declarations }
    procedure pMostraItensNFCompra;
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    strEspDoc  : String;
    blnCRM : Boolean;

    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosNFCompraClass = Class Of TfrmPnlDadosNFCompra;

implementation

uses untFuncoesSimples, untVerItensNFCompra, untGravando, untFuncoes;

{$R *.dfm}

{ TfrmPnlDadosNFCompra }

procedure TfrmPnlDadosNFCompra.btnItensCompradosClick(Sender: TObject);
begin
  If Assigned(cdsConsulta) And (Not cdsConsulta.IsEmpty) Then
  Begin
    If Not fVerificaAcessoSistema('EXIITECOM') Then
      fMensagem('', 'Operador não tem direito de acesso para visualizar itens comprados na consulta!', ['&O k'])
    Else
      pMostraItensNFCompra;
  End;
end;

constructor TfrmPnlDadosNFCompra.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmPnlDadosNFCompra.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F5 : Begin
              btnItensComprados.Click;
              Key := 0;
            End;
  End;
end;

procedure TfrmPnlDadosNFCompra.pMostraItensNFCompra;
  Var
    qryAux: TUniQuery;
    frmVerItensNFCompra: TfrmVerItensNFCompra;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  DET_CODITE AS CODITE, ');
  qryAux.SQL.Add('  DET_DESCRI AS DESITE, ');
  qryAux.SQL.Add('  DET_NUMLOT AS NUMLOT, ');
  qryAux.SQL.Add('  MAR_DESMAR AS DESMAR, ');
  qryAux.SQL.Add('  ITE_CODFAB AS CODFAB, ');
  qryAux.SQL.Add('  UNI_SIGUNI AS SIGUNI, ');
  qryAux.SQL.Add('  DET_QTDITE AS QTDITE  ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVDET ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = DET_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
  qryAux.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  DET_SEQGER = :SEQGER ');

  qryAux.SQL.Text := qryAux.SQL.Text + ' UNION ALL ' + AnsiReplaceStr(qryAux.SQL.Text, 'MOVDET', 'NOTDET');

  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  DESITE ');

  qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
  qryAux.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;

  qryAux.Open;

  TFloatField(qryAux.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD'));

  Try
    pCriarFormularios(TfrmVerItensNFCompra, frmVerItensNFCompra);
    frmVerItensNFCompra.dtsItens.DataSet := qryAux;
    frmVerItensNFCompra.Caption := frmVerItensNFCompra.Caption + ' - ' + cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    frmVerItensNFCompra.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmVerItensNFCompra);
  FreeAndNil(qryAux);
end;

end.
